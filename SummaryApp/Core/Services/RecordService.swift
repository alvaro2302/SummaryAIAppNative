import Foundation
import AVFoundation
internal import Combine

enum StateRecord {
    case recording, notRecording, idle, error
}

final class RecordService: ObservableObject {
    private var audioEngine: AVAudioEngine?
    private var isRecording = false
    
    // PCM puro (no base64)
    @Published var pcmData: Data = Data()
    var stateRecord : PassthroughSubject<StateRecord,Never> = .init()
    var stateRecordPublisher: AnyPublisher<StateRecord, Never> {
        stateRecord
            .eraseToAnyPublisher()
    }

    func startRecording() throws {
        guard !isRecording else { return }
        isRecording = true
        
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playAndRecord, mode: .default)
        try session.setPreferredSampleRate(16000)
        try session.setActive(true)
        
        audioEngine = AVAudioEngine()
        guard let engine = audioEngine else { return }
        let input = engine.inputNode
        let hwFormat = input.inputFormat(forBus: 0)
        
        let desiredFormat = AVAudioFormat(commonFormat: .pcmFormatInt16,
                                          sampleRate: 16000,
                                          channels: 1,
                                          interleaved: true)!
        
        let converter = AVAudioConverter(from: hwFormat, to: desiredFormat)!
        
        var capturedData = Data()
        
        input.installTap(onBus: 0, bufferSize: 1024, format: hwFormat) { buffer, _ in
            let pcmBuffer = AVAudioPCMBuffer(pcmFormat: desiredFormat, frameCapacity: buffer.frameLength)!
            
            var error: NSError?
            let inputBlock: AVAudioConverterInputBlock = { _, outStatus in
                outStatus.pointee = .haveData
                return buffer
            }
            
            converter.convert(to: pcmBuffer, error: &error, withInputFrom: inputBlock)
            guard let channelData = pcmBuffer.int16ChannelData else { return }
            let frameLength = Int(pcmBuffer.frameLength)
            let channel = channelData[0]
            
            for i in 0..<frameLength {
                var sample = channel[i].littleEndian
                withUnsafeBytes(of: &sample) { capturedData.append(contentsOf: $0) }
            }
            
            DispatchQueue.main.async {
                self.pcmData = capturedData
            }
        }
        
        try engine.start()
        stateRecord.send(.recording)
    }
    
    func stopRecording() {
        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine?.stop()
        audioEngine?.reset()
        audioEngine = nil
        isRecording = false
        stateRecord.send(.notRecording)
    }
}
