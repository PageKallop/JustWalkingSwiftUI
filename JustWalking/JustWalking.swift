//
//  JustWalking.swift
//  JustWalking
//
//  Created by Page Kallop on 2/9/21.
//

import WidgetKit
import SwiftUI
//import Intents

struct StepEntry: TimelineEntry {
    
    var date: Date = Date()
    var steps: Int
}

struct Provider: TimelineProvider {
   
    func placeholder(in context: Context) -> StepEntry {
        
        return StepEntry(steps: stepCount)
    }
    

    typealias Entry = StepEntry
   
    @AppStorage("stepCount", store: UserDefaults(suiteName: "Marie.Kallop.JustWalkingSwiftUI"))
    
    var stepCount: Int = 0
   
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        
        let entry = StepEntry(steps: stepCount)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
        let entry = StepEntry(steps: stepCount)
        completion(Timeline(entries: [entry], policy: .never))
    }
    
}

struct StepView: View {
    let entry: Provider.Entry
    
    var body: some View {
        Text("\(entry.steps)")
    }
}

@main
struct StepWidget: Widget {
    
    private let kind = "StepWidget"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: "StepWidget", provider: Provider(), content: { (entry)  in
           
            StepView(entry: entry)
            
            
        })
    }
}
