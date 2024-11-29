//
//  AnnualEventView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import SwiftUI

struct AnnualEventView: View {
    
    @Binding var eventName: String
    @Binding var progressValue: Int
    @Binding var min: Int
    @Binding var max: Int
    
    //Variable for gauge bcz gauge requires Double type
    private var minDouble: Double { Double(min) }
    private var maxDouble: Double { Double(max) }
    private var progressValueDouble: Double { Double(progressValue) }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            
            HStack {
                Text("\(eventName)")
                    .font(.callout)
                Spacer()
                Text("To D-Day")
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Gauge(value: progressValueDouble, in: minDouble...maxDouble) {
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
    AnnualEventView(eventName: .constant("Event Name"), progressValue: .constant(0), min: .constant(0), max: .constant(100))
}
