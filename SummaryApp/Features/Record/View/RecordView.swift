//
//  RecordView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 4/12/25.
//

import SwiftUI

struct RecordView: View {
    @StateObject private var viewModel: RecordViewModel = RecordViewModel()
    @State private var seconds: Int = 0
    @State private var stateRecord: StateTimer = .stop
    @State var isRecording: Bool = false
    var body: some View {
        GeometryReader { geometry in
            
    
        VStack(spacing: 0) {
            // Header
            Text("New Recording")
                .font(.headline)
                .bold()
                .padding(.top, 20)
            
            Spacer()
            
            // Controles de grabación
            VStack(spacing: 20) {
                TimerRecord(seconds: $seconds, stateRecord: $stateRecord)
                
                AnimationRecordView(flag: $isRecording, height: 200)
                
                Button {
                    handleMainButton()
                } label: {
                    Image(systemName: "microphone")
                        .resizable()
                        .frame(width: 20, height: 30)
                        .tint(.black)
                        .padding(10)
                        .frame(width: 100, height: 100)
                        .background(Color(CGColor(red: 48/255, green: 242/255, blue: 215/255, alpha: 1)))
                        .cornerRadius(50)
                        .shadow(radius: 10)
                }
            }
            
            Spacer()
            
            // Botones de acción - CON PRIORIDAD DE LAYOUT
            HStack(spacing: 20) {
                Button {
                    print("Pause tapped")
                } label: {
                    HStack {
                        Image(systemName: "pause")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(.black)
                        Text("Pause")
                            .foregroundColor(.black)
                            .font(.title3)
                            .bold()
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color(CGColor(red: 222/255, green: 225/255, blue: 230/255, alpha: 1)))
                    .cornerRadius(10)
                }
                
                Button {
                    print("Stop tapped")
                } label: {
                    HStack {
                        Image(systemName: "stop")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(.black)
                        Text("Stop")
                            .foregroundColor(.black)
                            .font(.title3)
                            .bold()
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color(CGColor(red: 222/255, green: 225/255, blue: 230/255, alpha: 1)))
                    .cornerRadius(10)
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 5)
            .padding(.bottom, 20)
            // ← ESTO ES CLAVE
        }.frame(width: geometry.size.width, height: geometry.size.height)
        }
        .padding(.horizontal, 20)
    }
    private func handleMainButton() {
        switch viewModel.stateRecording {
            case .idle, .notRecording:
                print("start recording")
                startRecording()
            case .recording:
                print("stop recording")
                stopRecording()
            default:
                break
            
        }
    }
    private func startRecording() {
        isRecording = true
        stateRecord = .start
        viewModel.startRecording()
    }
    private func stopRecording() {
        isRecording = false
        stateRecord = .stop
        viewModel.stopAndUpload()
    }
}

#Preview {
    RecordView()
}
