//
//  HomeView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 3/12/25.
//

import SwiftUI
enum Route: Hashable {
    case record
}

struct HomeView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
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
                        
                        path.append(Route.record)
                    }label: {
                        Image(systemName: "microphone").resizable().frame(width: 20, height: 20).tint(.black).padding(10)
                        Text("Start Recording").foregroundColor(.black).font(.title3).bold(true)
                    }.frame(maxWidth: .infinity, maxHeight: 55).background(Color(CGColor(red: 48/255, green: 242/255, blue: 215/255, alpha: 1)))
                }.frame(maxWidth: 350).cornerRadius(20)
                Spacer()
                ListCardRecords()
                Spacer()
            }.padding(.horizontal, 20).navigationDestination(for: Route.self) { route in
                switch route {
                    case .record:
                        RecordView()
                }
            }

        }    }
}

#Preview {
    HomeView()
}
