//
//  TimerRecord.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 10/12/25.
//

import SwiftUI
internal import Combine
enum StateTimer {
    case start
    case stop
    case pause
}

struct TimerRecord: View {
  
    @Binding var seconds: Int
    @Binding var stateRecord: StateTimer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var formattedMinutes: String {
        let minutesFormat: Int = Int(floor(Double(self.seconds) / 60))
        return getFormatTimer(value: minutesFormat)
    }
    var formattedSeconds: String {
        let secondsFormat: Int = Int(floor(Double(self.seconds).truncatingRemainder(dividingBy: 60)))
        return getFormatTimer(value: secondsFormat)
    }
    var body: some View {
        VStack {
            Text("\(formattedMinutes):\(formattedSeconds)").fontWeight(.bold).font(.custom("Arial", size: 55))
        }.onReceive(timer) { _ in
            if stateRecord == .start {
                seconds += 1
            }
        }.onChange(of: stateRecord) { newState in
            if newState == .stop {
                seconds = 0
            }
        }
    }
    func getFormatTimer(value: Int) -> String {
        if(value < 10) {
            return "0\(value)"
        } else {
            return String(value)
        }
    }
}

#Preview {
    @Previewable @State var seconds: Int = 0
    @Previewable @State var stateRecord: StateTimer = .pause
    TimerRecord(seconds: $seconds, stateRecord: $stateRecord)
}
