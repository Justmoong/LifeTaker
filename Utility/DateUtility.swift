//
//  DateUtility.swift
//  Chrono
//
//  Created by ymy on 1/17/25.
//

import Foundation
import SwiftUI

public let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

public let lengthOfYear: Int = 365

let now = Date()
let calendar = Calendar.current
