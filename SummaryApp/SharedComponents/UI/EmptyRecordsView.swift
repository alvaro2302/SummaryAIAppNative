//
//  EmptyRecordsView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 4/12/25.
//

import SwiftUI

struct EmptyRecordsView: View {
    var body: some View {
        VStack {
            Image("folderEmpty").resizable().frame(width: 50, height: 50).cornerRadius(25)
            Text("No Recording Yet").font(Font.title2.bold())
            Text("Tap 'Start Recording' to begin.").foregroundColor(.gray)
        }.frame(maxWidth: .infinity, alignment: .init(horizontal: .center, vertical: .center)).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 1,dash: [3])).foregroundColor(.gray))
    }
}

#Preview {
    EmptyRecordsView()
}
