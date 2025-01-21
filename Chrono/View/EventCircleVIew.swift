//
//  EventCircleVIew.swift
//  Chrono
//
//  Created by ymy on 1/21/25.
//

import Foundation
import SwiftUI

struct EventPlainView: View {
    
    var title: String
    var count: Int
    var gaugeValue: Int
    var min: Int
    var max: Int
    
    var body: some View {
        HStack (spacing: 16) {
            Text(title)
                .font(.callout)
            Spacer()

            Text("\(count)")
                .font(.headline)
                .foregroundStyle(Color.accentColor)
//            }
//            .gaugeStyle(.accessoryCircularCapacity)
//            .foregroundStyle(Color.accentColor)
//            .tint(Color.accentColor)
        }
    }
}

#Preview {
    EventPlainView(
        title: "Christmas",
        count: 1,
        gaugeValue: 1,
        min: 1,
        max: 365
    )
}
