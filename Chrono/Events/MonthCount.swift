//
//  AnnualEvent.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//
import Foundation
import Combine
import SwiftUICore

class MonthCount: ObservableObject {
    @Published var leftMonths: Int = 0 {
        didSet {
            print("Remaining months: \(leftMonths)")
        }
    }

    @ObservedObject var userData: UserData
//
    init(viewModel: UserData) {
        self.userData = viewModel
        calculateMonths()
    }
    func calculateMonths() {
        let deathDate = userData.deathDate

        let leftComponents = calendar.dateComponents([.year, .month], from: now, to: deathDate)
        leftMonths = max((leftComponents.year ?? 0) * 12 + (leftComponents.month ?? 0), 0)
        print(#function, #file, #line, "Remaining months: \(leftMonths)")
    }
}
