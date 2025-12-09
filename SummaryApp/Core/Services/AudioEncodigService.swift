//
//  AudioEncodigService.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 9/12/25.
//

import Foundation
final class AudioEncodigService {
    
    func buildWav(from base64Chunks: [String], sampleRate: Int = 16000, channels: Int = 1, bitsPerChannel: Int = 16) -> Data {
        let pcmData = concatPCM(from: base64Chunks)
        return pcmToWAV(pcmData: pcmData, sampleRate: sampleRate, channels: channels, bitsPerChannel: bitsPerChannel)
    }
    
    private func concatPCM(from base64Chunks: [String]) -> Data {
        var finalData: Data = Data()
        for chunk in base64Chunks {
            if let data = Data(base64Encoded: chunk) {
                finalData.append(data)
            }
        }
        return finalData
    }
    
    private func pcmToWAV(pcmData: Data, sampleRate: Int = 16000, channels: Int = 1, bitsPerChannel: Int = 16) -> Data {
        let byteRate: Int = sampleRate * channels * bitsPerChannel / 8
        let blockAlign: Int = channels * bitsPerChannel / 8
        let dataSize = UInt32(pcmData.count)
        let chunkSize = 36 + dataSize
        var wav = Data()
        
        wav.append("RIFF".data(using: .utf8)!)
        wav.append(chunkSize.littleEndianData)
        // WAVE + fmt subchunk
        wav.append("WAVE".data(using: .utf8)!)
        wav.append("fmt ".data(using: .utf8)!)
        wav.append(UInt32(16).littleEndianData)        // Subchunk1Size
        wav.append(UInt16(1).littleEndianData)         // AudioFormat = PCM
        wav.append(UInt16(channels).littleEndianData)
        wav.append(UInt32(sampleRate).littleEndianData)
        wav.append(UInt32(byteRate).littleEndianData)
        wav.append(UInt16(blockAlign).littleEndianData)
        wav.append(UInt16(bitsPerChannel).littleEndianData)

        // data subchunk
        wav.append("data".data(using: .utf8)!)
        wav.append(UInt32(dataSize).littleEndianData)
        wav.append(pcmData)

        return wav
    }
}
private extension FixedWidthInteger {
    var littleEndianData: Data {
        var value = self.littleEndian
        return Data(bytes: &value, count: MemoryLayout<Self>.size)
    }
}
