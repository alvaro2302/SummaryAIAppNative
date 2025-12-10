//
//  AudioEncodigService.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 9/12/25.
//

import Foundation
final class AudioEncodigService {
    
    func pcmToWav(pcmData: Data, sampleRate: Int = 16000, channels: Int = 1, bitsPerSample: Int = 16) -> Data {
           let byteRate = sampleRate * channels * bitsPerSample / 8
           let blockAlign = channels * bitsPerSample / 8
           let dataSize = UInt32(pcmData.count)
           let chunkSize = 36 + dataSize
           
           var wav = Data()
           wav.append("RIFF".data(using: .utf8)!)
           wav.append(UInt32(chunkSize).littleEndianData)
           wav.append("WAVE".data(using: .utf8)!)
           wav.append("fmt ".data(using: .utf8)!)
           wav.append(UInt32(16).littleEndianData) // Subchunk1Size
           wav.append(UInt16(1).littleEndianData)  // PCM
           wav.append(UInt16(channels).littleEndianData)
           wav.append(UInt32(sampleRate).littleEndianData)
           wav.append(UInt32(byteRate).littleEndianData)
           wav.append(UInt16(blockAlign).littleEndianData)
           wav.append(UInt16(bitsPerSample).littleEndianData)
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
