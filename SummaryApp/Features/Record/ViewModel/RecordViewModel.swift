//
//  RecordViewModel.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 7/12/25.
//

internal import Combine
import SwiftUI
class RecordViewModel: ObservableObject {
    @Published var dataRecording: Data? = nil
    @Published var stateRecording: StateRecord = .idle
    private let recordService: RecordService
    private var cancellables = Set<AnyCancellable>()
    init(recordService: RecordService = RecordService()) {
        self.recordService = recordService
        setupBindings()
    }
    
    private func setupBindings() {
        recordService.dataAudio.receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.dataRecording = data
                
            }
            .store(in: &cancellables)
        recordService.stateRecordPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.stateRecording = state
            }
            .store(in: &cancellables)
        
    }
    func starRecording() {
        do {
            try recordService.startRecording()
        } catch {
            print("Error starting recording: \(error)")
        }
        
    }
    func stopRecording() {
        recordService.stopRecording()
        
    }
    
}
