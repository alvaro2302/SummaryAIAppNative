//
//  TalkingService.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 9/12/25.
//
import Foundation
struct UploadAudioRequest: Codable {
    let audio: String
}
class TalkingService {
    func sentRecording(dataAudio: Data) async throws -> UploadRecordReponse {
        let APIKEY = "APIKEY_HERE"
        let url = URL(string: "https://api.assemblyai.com/v2/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(APIKEY, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("audio/wave", forHTTPHeaderField: "Content-Type")
        print("Data length:", dataAudio.count)
        print("First 20 bytes:", dataAudio.prefix(20))
        request.httpBody = dataAudio
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print("RESPONSE",response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(UploadRecordReponse.self, from: data)
        
    }
    func startTranscription(audioURL: String) async throws -> TranscriptRecordResponse {
        let APIKEY = "API_KEY"
        let url = URL(string: "https://api.assemblyai.com/v2/transcript")!
        let body: TranscriptRecord = TranscriptRecord(audioUrl: audioURL, languageDetection: true)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(APIKEY, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(TranscriptRecordResponse.self, from: data)
    }
}
