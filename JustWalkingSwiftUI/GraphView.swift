//
//  GraphView.swift
//  JustWalkingSwiftUI
//
//  Created by Page Kallop on 2/10/21.
//

import SwiftUI

struct GraphView: View {
    
    let steps: [Step]
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            ForEach(steps, id: \.id) { step in
                
                let yValue = Swift.min(step.count/20, 300)
                VStack {
                    Text("\(step.count)")
                    Rectangle()
                    .fill(Color.red)
                        .frame(width: 20, height: CGFloat(yValue))
                }
            }
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
