//
//  TranscriptRecord.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 11/12/25.
//
struct TranscriptRecord: Codable {
    let audioUrl: String
    let languageDetection: Bool
    enum CodingKeys: String, CodingKey {
        case audioUrl = "audio_url"
        case languageDetection = "language_detection"
    }
}
