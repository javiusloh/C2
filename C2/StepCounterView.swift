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
//    @AppStorage("stepGoal") var stepGoal: Int = 10000
//    @AppStorage("distanceGoal") var distanceGoal: Double = 5.0
//    @AppStorage("userDistance") var storedDistance: Double = 0.0
//    @AppStorage("userSteps") var storedSteps: Int = 0
    
    var body: some View {
        
        let userDefaults = UserDefaults.standard
        let stepGoal = userDefaults.integer(forKey: "stepGoal")
        let distanceGoal = userDefaults.double(forKey: "distanceGoal")
        let userSteps = userDefaults.double(forKey: "userSteps")
        let userDistance = userDefaults.double(forKey: "userDistance")
        
        // stepGoal and distanceGoal must not be 0 or else divide by zero error
        
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
                        Circle()
                            .stroke(
                                Color.gray.opacity(0.4), style: StrokeStyle(
                                lineWidth: 10,
                                lineCap: .round
                                )
                            )
                            .frame(width: 130, height: 130)
                            .rotationEffect(.degrees(270))
                        Circle()
                            .trim(from: 0, to: Double(userSteps)/Double(stepGoal))
                            .stroke(
                                Color.blue, style: StrokeStyle(
                                lineWidth: 10,
                                lineCap: .round
                                )
                            )
                            .frame(width: 130, height: 130)
                            .rotationEffect(.degrees(270))
                    }
                    .padding()
                    ZStack{
                        VStack{
                            Text(String(format: "%.1f", viewModel.storedDistance))
                                .font(.largeTitle)
                            Text("km")
                                .foregroundStyle(.gray)
                        }
                        Circle()
                            .stroke(
                                Color.gray.opacity(0.4), style: StrokeStyle(
                                lineWidth: 10,
                                lineCap: .round
                                )
                            )
                            .frame(width: 130, height: 130)
                            .rotationEffect(.degrees(270))
                        Circle()
                            .trim(from: 0, to: userDistance/distanceGoal)
                            .stroke(
                                Color.blue, style: StrokeStyle(
                                lineWidth: 10,
                                lineCap: .round
                                )
                            )
                            .frame(width: 130, height: 130)
                            .rotationEffect(.degrees(270))
                    }
                    .padding()
                }
            }
        }
        .padding()
        .task {
            await viewModel.requestAuth()
            try? await viewModel.fetchTodayStepsAndDistance()
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
    @Published var distance: Double = 0.0
    
    @AppStorage("userDistance") var storedDistance: Double = 0.0
    @AppStorage("userSteps") var storedSteps: Int = 0
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            steps = storedSteps
            distance = storedDistance
        } else {
            error = StepCounterError.couldNotFetchHealthStore
        }
    }
    
    func requestAuth() async {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
              let healthStore else { return }
        
        do {
            try await healthStore.requestAuthorization(toShare: [], read: [stepCountType, distanceType])
        } catch {
            self.error = error
        }
    }
    
    func fetchTodayStepsAndDistance() async throws {
        guard let healthStore else { return }
        
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let stepsQuery = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, statistics, error in
            guard let statistics = statistics, let sum = statistics.sumQuantity() else { return }
            DispatchQueue.main.async {
                let stepCount = Int(sum.doubleValue(for: .count()))
                self.steps = stepCount
                self.storedSteps = stepCount
            }
        }
        
        let distanceQuery = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, statistics, error in
            guard let statistics = statistics, let sum = statistics.sumQuantity() else { return }
            DispatchQueue.main.async {
                let distanceValue = sum.doubleValue(for: .meterUnit(with: .kilo))
                self.distance = distanceValue
                self.storedDistance = distanceValue
            }
        }
        
        healthStore.execute(stepsQuery)
        healthStore.execute(distanceQuery)
    }
}

#Preview {
    StepCounterView()
}
