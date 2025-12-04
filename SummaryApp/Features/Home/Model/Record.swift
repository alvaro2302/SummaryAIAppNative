//
//  Record.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 3/12/25.
//

struct Record: Identifiable, Codable {
    var id: String
    var title: String
    var transcription: String
    var duration: Int
}
