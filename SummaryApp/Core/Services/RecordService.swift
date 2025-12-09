//
//  RecordService.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 5/12/25.
//
import Foundation
import AVFoundation
internal import Combine

enum StateRecord {
    case recording
    case notRecording
    case idle
    case error
}

class RecordService: ObservableObject {
    private var audioEngine: AVAudioEngine?
    private var converterNode: AVAudioMixerNode
    private var isRecording: Bool = false
    var audioData: Data = Data()
    var dataAudio: CurrentValueSubject<Data, Never> = .init(Data())
    var stateRecord : PassthroughSubject<StateRecord,Never> = .init()
    var stateRecordPublisher: AnyPublisher<StateRecord, Never> {
        stateRecord
            .eraseToAnyPublisher()
    }
    var dataAudioPublisher: AnyPublisher<Data, Never> {
        dataAudio.eraseToAnyPublisher()
    }
    init() {
        self.converterNode = AVAudioMixerNode()
        stateRecord.send(.idle)
    }
    
    func startRecording() throws {
        guard !isRecording else { return }
        isRecording = true
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setPreferredSampleRate(16000)
            try session.setActive(true)
            audioEngine = AVAudioEngine()
            guard let engine = audioEngine else { return }
            let input = engine.inputNode
            let hwFormat = input.inputFormat(forBus: 0)
            
            let desiredFormat = AVAudioFormat(commonFormat: .pcmFormatInt32,sampleRate: 16000, channels: 1, interleaved: false)!
            let converter = AVAudioConverter(from: hwFormat, to: desiredFormat)!
            input.installTap(onBus: 0, bufferSize: 1024, format: hwFormat) { [weak self] (buffer, time) in
                guard let self else { return }
                let converted = AVAudioPCMBuffer(pcmFormat: desiredFormat, frameCapacity: AVAudioFrameCount(desiredFormat.sampleRate / 10))!
                var error: NSError?
                let inputBlock: AVAudioConverterInputBlock = { (_, outStatus) in
                    outStatus.pointee = .haveData
                    return buffer
                }
                converter.convert(to: converted, error: &error, withInputFrom: inputBlock)
                if let err = error {
                    return
                }
                
                self.sendPCMFloatBuffer(converted)
            }
            try engine.start()
            stateRecord.send(.recording)
        } catch {
            stateRecord.send(.error)
            isRecording = false
            throw error
            
        }
        
    }
    private func sendPCMFloatBuffer(_ buffer: AVAudioPCMBuffer) {
        guard let floatChannelData = buffer.floatChannelData else { return }
        let frames = Int(buffer.frameLength)

        var out = Data(capacity: frames * 2)
        let channel = floatChannelData[0]

        for i in 0..<frames {
            let float = max(-1, min(1, channel[i]))
            var int16 = Int16(float * Float(Int16.max)).littleEndian
            withUnsafeBytes(of: &int16) { out.append(contentsOf: $0) }
        }

        let base64 = out.base64EncodedString()
        audioData = Data(base64.utf8)
        dataAudio.send(audioData)
    }
    @objc func stopRecording() {
        defer {
            isRecording = false
        }
        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine?.stop()
        audioEngine = nil
        stateRecord.send(.notRecording)
        
    }
    
}
