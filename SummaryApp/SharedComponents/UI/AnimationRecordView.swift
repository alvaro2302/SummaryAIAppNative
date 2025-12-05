//
//  AnimationRecordView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 4/12/25.
//

import SwiftUI
internal import Combine

struct AnimationRecordView: View {
    @Binding var flag: Bool
    @State private var heightsIndex = 0
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var heights: [CGFloat] = Array(2...40).map { _ in CGFloat.random(in: 10...40) }
    let colorAnimation = Color(red: 48/255, green: 242/255, blue: 215/255)
    let withRectangles = CGFloat(5)
    @State var height: CGFloat = CGFloat(200)
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: height)
                .ignoresSafeArea()
                .foregroundColor(.white)
                HStack {
                    
                    ForEach(heights.indices, id: \.self) { index in
                        Rectangle()
                            .foregroundColor(colorAnimation)
                            .frame(width: withRectangles, height: heights[index], alignment: .leading)
                            .offset(x: 0, y: -( heights[index]/2) )
                            .animation(.easeInOut, value: heights[index])
                    }
                    
                }
                HStack {
                    
                    ForEach(heights.indices, id: \.self) { index in
                        Rectangle()
                            .foregroundColor(colorAnimation)
                            .frame(width: withRectangles, height: heights[index], alignment: .leading)
                            .offset(x: 0, y: ( heights[index]/2) )
                            .animation(.easeInOut, value: heights[index])
                    }
                    
                }
      
        }
        .onReceive(timer) { _ in
            if(flag) {
                print("count \(heights.count)")
                heights = heights.map{_ in CGFloat(arc4random_uniform(100))}
                heights.forEach { print($0) }
            }
        }
    }
}

#Preview {
    
    @State var flag: Bool = true
    AnimationRecordView(flag: $flag)
}
