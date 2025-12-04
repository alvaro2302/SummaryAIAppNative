//
//  HomeView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 3/12/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                
                Text("TalkSense").font(.title2).bold(true).padding(10)
                
                
            }.frame(maxWidth: .infinity).overlay(alignment: .trailing) {
                Button (action: {
                    print("touch search")
                }){
                    Image(systemName: "magnifyingglass").tint(Color.black)
                }.padding(10)
            }
            VStack(alignment: .center) {
                Button {
                    
                }label: {
                    Image(systemName: "microphone").resizable().frame(width: 20, height: 20).tint(.black).padding(10)
                    Text("Start Recording").foregroundColor(.black).font(.title3).bold(true)
                }.frame(maxWidth: .infinity, maxHeight: 55).background(Color(CGColor(red: 48/255, green: 242/255, blue: 215/255, alpha: 1)))
            }.frame(maxWidth: 350).cornerRadius(20)
            
            List {
                Section(header: Text("My Recordings").font(.title2).foregroundColor(.black).bold(true)) {
                    CardRecord(record: Record(id: "1", title: "Marketing Strategy Q3", transcription: "fsdfdssf fsdfsddsfdfsds fdsfsdfsdfdfssdf fdsfdsfsdsdfsdf fsdsdfsdfsdf sdffsdsdfdfdfdf fdsfsddsf", duration: 32))
                    CardRecord(record: Record(id: "2", title: "Marketing Strategy Q3", transcription: "fsdfdssf fsdfsddsfdfsds fdsfsdfsdfdfssdf fdsfdsfsdsdfsdf fsdsdfsdfsdf sdffsdsdfdfdfdf fdsfsddsf", duration: 20))
                }
              
            }.listStyle(.plain)
        }
    }
}

#Preview {
    HomeView()
}
