//
//  WalkingView.swift
//  JustWalkingSwiftUI
//
//  Created by Page Kallop on 2/10/21.
//

import SwiftUI
import HealthKit

struct WalkingView: View {
    
    
    
    private var healthStore: HealthStore?
    
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Double(count ?? 0.0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
    var body: some View {
       
        List(steps, id: \.id) { step in
            VStack {
            Text("\(step.count)")
                Text(step.date, style: .date)
                    .opacity(0.5)
            }
        }
            .onAppear() {
                if let healthStore = healthStore {
                    healthStore.requestAuthorization(completion: { (success) in
                        if success {
                            healthStore.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    updateUIFromStatistics(statisticsCollection)
                                }
                            }
                        }
                    })
                }
            }
    }
}



struct WalkingView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingView()
    }
}
