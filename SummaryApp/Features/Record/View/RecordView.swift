//
//  RecordView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 4/12/25.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        VStack {
            Text("New Recording")
                .font(.headline).bold()
            HStack {
                Text("01:15").font(.custom("Arial", size: 55)).bold().fontWeight(Font.Weight.black)
            }
            
            
        }
    }
}

#Preview {
    RecordView()
}
