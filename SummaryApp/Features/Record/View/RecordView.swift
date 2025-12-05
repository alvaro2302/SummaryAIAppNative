//
//  RecordView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 4/12/25.
//

import SwiftUI

struct RecordView: View {
    @State var isRecording: Bool = false
    var body: some View {
        VStack {
            Text("New Recording")
                .font(.headline).bold()
            
            VStack {
                HStack {
                    Text("01:15").font(.custom("Arial", size: 55)).bold().fontWeight(Font.Weight.black)
                }
                
                AnimationRecordView(flag: $isRecording, height: 200)
                Button {
                    isRecording.toggle()
                }label: {
                    Image(systemName: "microphone").resizable().frame(width: 20, height: 30).tint(.black).padding(10)
                    
                }.frame(maxWidth: 100, maxHeight: 100).background(Color(CGColor(red: 48/255, green: 242/255, blue: 215/255, alpha: 1))).cornerRadius(50).shadow(radius: 10)
            }.padding(.top, 100)
            Spacer()
            VStack {
               

                HStack {
                    Button {
                        
                    }label: {
                        Image(systemName: "pause").resizable().frame(width: 20, height: 20).tint(.black).padding(10)
                        Text("Pause").foregroundColor(.black).font(.title3).bold(true)
                    }.frame(maxWidth: 220, maxHeight: 55).background(Color(CGColor(red: 222/255, green: 225/255, blue: 230/255, alpha: 1))).cornerRadius(10)
                    Button {
                        
                    }label: {
                        Image(systemName: "stop").resizable().frame(width: 20, height: 20).tint(.black).padding(10)
                        Text("Stop").foregroundColor(.black).font(.title3).bold(true)
                    }.frame(maxWidth: 220, maxHeight: 55).background(Color(CGColor(red: 222/255, green: 225/255, blue: 230/255, alpha: 1))).cornerRadius(10)
                }
            }
           
            
        }.padding(.horizontal,20)
    }
}

#Preview {
    RecordView()
}
