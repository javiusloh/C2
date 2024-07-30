//
//  StepCounterView.swift
//  C2
//
//  Created by T Krobot on 27/7/24.
//

import SwiftUI
import HealthKit

struct StepCounterView: View {
    @StateObject private var viewModel = StepCounterViewModel()
    
    var body: some View {
        VStack {
            if viewModel.error != nil {
                ContentUnavailableView("No Steps Data", systemImage: "figure.walk")
            } else {
                HStack{
                    ZStack{
                        VStack{
                            Text("\(viewModel.steps)")
                                .font(.largeTitle)
                            Text("steps")
                                .foregroundStyle(.gray)
                        }
                        Image(systemName: "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)
                        .foregroundStyle(.blue)
                    }
                    .padding()
                    ZStack{
                        VStack{
                            Text("0.0")
                                .font(.largeTitle)
                            Text("km")
                                .foregroundStyle(.gray)
                        }
                        Image(systemName: "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)
                        .foregroundStyle(.blue)
                    }
                    .padding()
                }
            }
        }
        .padding()
        .task {
            await viewModel.requestAuth()
            try? await viewModel.fetchTodaySteps()
        }
    }
}

enum StepCounterError: Error {
    case couldNotFetchHealthStore
}

final class StepCounterViewModel: ObservableObject {
    
    @Published var healthStore: HKHealthStore?
    @Published var error: Error? = nil
    @Published var steps: Int = 0
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            error = StepCounterError.couldNotFetchHealthStore
        }
    }
    
    func requestAuth() async { // second step
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let healthStore else { return }
        
        do {
            try await healthStore.requestAuthorization(toShare: [], read: [stepCountType])
        } catch {
            self.error = error
        }
    }
    
    func fetchTodaySteps() async throws {
        guard let healthStore else { return }
        
        let startDate = Calendar.current.date(bySettingHour: 1, minute: 0, second: 0, of: Date())!
        let healthStepType = HKQuantityType(.stepCount)
        
        let sampleDateRange = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        
        let sample = HKSamplePredicate.quantitySample(type: healthStepType, predicate: sampleDateRange)
        
        let stepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: sample, options: .mostRecent, anchorDate: Date(), intervalComponents: DateComponents(day:1))
        
        let stepsData = try await stepsQuery.result(for: healthStore)
        
        stepsData.enumerateStatistics(from: startDate, to: Date()) { statistics, pointer in
            let stepCount = statistics.sumQuantity()?.doubleValue(for: .count())
            DispatchQueue.main.async {
                if let stepCount, stepCount > 0 {
                    self.steps = Int(stepCount)
                }
            }
        }
    }
}

#Preview {
    StepCounterView()
}
