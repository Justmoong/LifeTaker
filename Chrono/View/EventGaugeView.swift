//
//  AnnualEventView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import SwiftUI

struct EventGaugeView: View {
    
    @State var title: String
    @State var count: Int
    @State var gaugeValue: Int
    @State var min: Int
    @State var max: Int
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack {
                Text(title)
                    .font(.callout)
                Spacer()
                Text("\(count)")
                    .foregroundStyle(Color.accentColor)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            Gauge(value: Double(gaugeValue), in: Double(min)...Double(max)) {
                Text("\(gaugeValue)")
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .foregroundStyle(Color.accentColor)
            .tint(Color.accentColor)
            .labelsHidden()
            .font(.headline)
        }
        .padding(.vertical, 8)
    }
}

