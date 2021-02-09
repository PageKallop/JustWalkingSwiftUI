//
//  ContentView.swift
//  JustWalkingSwiftUI
//
//  Created by Page Kallop on 2/9/21.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    private let pedometer: CMPedometer = CMPedometer()
    
    @State private var steps: Int?
    
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() &&
            CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    private func initializePedometer() {
        if isPedometerAvailable {
            guard let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
                return
            }
            
            pedometer.queryPedometerData(from: startDate, to: Date()) { (data, error) in
                guard let data = data, error == nil else { return }
                
                steps = data.numberOfSteps.intValue
            }
        }
        
    }
    
    var body: some View {
        Text(steps != nil ? "\(steps!)" : "")
            .padding()
            .onAppear() {
                initializePedometer()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
