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
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
        }
        
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear() {
                if let healthStore = healthStore {
                    healthStore.requestAuthorization(completion: { (success) in
                        if success {
                            healthStore.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    
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
