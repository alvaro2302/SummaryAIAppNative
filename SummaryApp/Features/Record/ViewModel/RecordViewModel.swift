//
//  RecordViewModel.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 7/12/25.
//

internal import Combine
import Foundation
@MainActor
final class RecordViewModel: ObservableObject {
    @Published var stateRecording: StateRecord = .idle
    @Published var wavData: Data? = nil
    
    private let recordService = RecordService()
    private let encoder = AudioEncodigService()
    private let uploader = TalkingService()
    private var cancellables = Set<AnyCancellable>()
    init () {
        buildSetup()
    }
    func buildSetup() {
        recordService.stateRecordPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.stateRecording = state
            }
            .store(in: &cancellables)
    }
    
    func startRecording() {
        do { try recordService.startRecording() }
        catch { print(error) }
    }
    
    func stopAndUpload()  {
        recordService.stopRecording()
        let wav = encoder.pcmToWav(pcmData: recordService.pcmData)
        self.wavData = wav
        Task {
            do {
                let url = try await uploader.sentRecording(dataAudio: wav)
                print("Upload URL:", url)
            } catch {
                print("Upload failed:", error)
            }
        }
    }
}
