//
//  RecordReponse.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 9/12/25.
//
struct UploadRecordReponse: Codable {
    let uploadURL: String
    enum CodingKeys: String, CodingKey {
        case uploadURL = "upload_url"
    }
}
