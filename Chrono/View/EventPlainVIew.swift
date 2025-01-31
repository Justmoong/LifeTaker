//
//  EventCircleVIew.swift
//  Chrono
//
//  Created by ymy on 1/21/25.
//

import Foundation
import SwiftUI
import Combine

struct EventPlainView: View {
    var title: String
    var count: Int
    
    var body: some View {
        HStack(spacing: 16) {
            Text(title)
                .font(.callout)
            Spacer()
            Text("\(count)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.accentColor)
        }
    }
}
