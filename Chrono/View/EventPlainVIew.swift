//
//  EventCircleVIew.swift
//  Chrono
//
//  Created by ymy on 1/21/25.
//

import Foundation
import SwiftUI

struct EventPlainView: View {
    
    @State var title: String
    @State var count: Int
    
    var body: some View {
        HStack (spacing: 16) {
            Text(title)
                .font(.callout)
            Spacer()

            Text("\(count)")
                .font(.headline)
                .foregroundStyle(Color.accentColor)
        }
    }
}
