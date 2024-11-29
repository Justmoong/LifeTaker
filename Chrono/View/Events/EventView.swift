//
//  AnnualEventView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import SwiftUI

struct EventView: View {
    
    @Binding var eventName: String
    @Binding var dDay: Int
    @Binding var gaugeValue: Int
    @Binding var min: Int
    @Binding var max: Int
    
    //Variable for gauge bcz gauge requires Double type
    var minDouble: Double { Double(min) }
    var maxDouble: Double { Double(max) }
    var gaugeValueDouble: Double { Double(gaugeValue) }
    var dDayDouble: Double { Double(dDay) }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            
            HStack {
                Text("\(eventName)")
                    .font(.callout)
                Spacer()
                Text("\(dDay)")
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Gauge(value: gaugeValueDouble, in: minDouble...maxDouble) {
                Text("Hide it to LabelIsHidden")
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .foregroundStyle(Color.accentColor)
            .tint(Color.accentColor)
            .labelsHidden()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    EventView(eventName: .constant("Event Name"), dDay: .constant(5), gaugeValue: .constant(0), min: .constant(0), max: .constant(100))
}
