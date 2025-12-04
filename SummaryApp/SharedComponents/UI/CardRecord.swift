//
//  CardRecord.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 3/12/25.
//

import SwiftUI

struct CardRecord: View {
    @State var record: Record
    var body: some View {
        VStack {
          
            Text(record.title).font(Font.title.bold()).padding(10)
            VStack {
                Text(record.transcription).lineLimit(4).multilineTextAlignment(.center).padding(.horizontal, 10).frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
            }.frame( height: 100, alignment: .center).padding(.horizontal, 20)
            VStack {
                Text(" \(record.duration) min").padding(.horizontal,2)
            }.frame(maxWidth: .infinity, maxHeight: 30, alignment: .init(horizontal: .leading, vertical: .center)).padding(.horizontal, 20)
        }.frame(maxWidth: .infinity, maxHeight: 240).background(.white).cornerRadius(20).shadow(radius: 10)
    }
}

#Preview {
    CardRecord(record: Record(id: "1", title: "Marketing Strategy Q3", transcription: "Kefsdsdafsdf fsdfdsf asdf sd Kefsdsdafsdf fsdfdsf asdf sd fsdfdsf asdf sd Kefsdsdafsdf fsdfdsf asdf sd Kefsdsdafsdf fsdfdsf asdf sd Kefsdsdafsdf fsdfdsf asdf sd fsdfdsf asdf sd Kefsdsdafsdf fsdfdsf asdf sd", duration: 32))
}
