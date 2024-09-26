//
//  Item.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
