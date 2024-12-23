//
//  AnnualEventView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import SwiftUI

struct EventView: View {
    
    @StateObject var eventStore: EventsProperties
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack {
                Text(eventStore.name)
                    .font(.callout)
                Spacer()
                Text("\(eventStore.count)")
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Gauge(value: Double(eventStore.gaugeValue), in: Double(eventStore.min)...Double(eventStore.max)) {
                Text("Progress") // 레이블로 사용할 텍스트
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .foregroundStyle(Color.accentColor)
            .tint(Color.accentColor)
            .labelsHidden()
        }
        .padding(.vertical, 8)
    }
}
