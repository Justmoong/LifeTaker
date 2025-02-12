//
//  LifespanModifier.swift
//  Chrono
//
//  Created by ymy on 2/12/25.
//

import Foundation
import Combine
import SwiftUICore

class LifespanModifier {
    @ObservedObject var userData: UserData
    @ObservedObject var healthData: HealthManager
    
    init(model: UserData, healthModel: HealthManager) {
        userData = model
        self.healthData = healthModel
    }
    
    
}
