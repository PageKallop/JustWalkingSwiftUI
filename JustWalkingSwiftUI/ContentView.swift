//
//  ContentView.swift
//  JustWalkingSwiftUI
//
//  Created by Page Kallop on 2/9/21.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    @AppStorage("stepCount", store: UserDefaults(suiteName: "group.com.Marie.Kallop.JustWalkingSwiftUI"))
    var stepCount: Int = 0
    
    private let pedometer: CMPedometer = CMPedometer()
    
    @State private var steps: Int?
    
    @State private var distance: Double?
    
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() &&
            CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    private func updateUI(data: CMPedometerData) {
        
        stepCount = data.numberOfSteps.intValue
        steps = data.numberOfSteps.intValue
        
        guard let pedometerDistance
                = data.distance else { return }
        let distanceInMeters = Measurement(value: Double(truncating: pedometerDistance), unit: UnitLength.meters)
         
        distance = distanceInMeters.converted(to: .miles).value
        
    }
    
    private func initializePedometer() {
        if isPedometerAvailable {
            guard let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
                return
            }
            
            pedometer.queryPedometerData(from: startDate, to: Date()) { (data, error) in
                guard let data = data, error == nil else { return }
                
                updateUI(data: data)
                steps = data.numberOfSteps.intValue
                distance = data.distance?.doubleValue
            }
        }
        
    }
    
    var body: some View {
        Text(steps != nil ? "\(steps!) steps" : "")
        Text(distance != nil ? String(format: "%.f miles", distance!) : "")
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
