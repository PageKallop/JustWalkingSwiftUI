//
//  GraphView.swift
//  JustWalkingSwiftUI
//
//  Created by Page Kallop on 2/10/21.
//

import SwiftUI

struct GraphView: View {
    
    static let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    let steps: [Step]
    
    var totalSteps : Double {
        
        steps.map { $0.count }.reduce(0, +)
    }
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                ForEach(steps, id: \.id) { step in
                    
                    let yValue = Swift.min(step.count/20, 300)
                    VStack {
                        Text("\(step.count)")
                        Rectangle()
                            .fill(step.count > 3000 ? Color.green : Color.red)
                            .frame(width: 20, height: CGFloat(yValue))
                        Text("\( step.date, formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                }
            }
            
            Text("Total Steps: \(totalSteps)").padding(.top, 100)
                .foregroundColor(Color.white)
                .opacity(0.5)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .cornerRadius(10)
        .padding(10)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [Step(count: 1234, date: Date()),
                     Step(count: 2345, date: Date()),
                     Step(count: 3456, date: Date())]
        GraphView(steps: steps)
    }
}
