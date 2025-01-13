import Foundation
import SwiftUI
import PlaygroundSupport

class UserData: ObservableObject {
    @Published var name: String
    @Published var birthday: Date
    @Published var deathDate: Date
    @Published var age: Int
    @Published var deathAge: Int
    @Published var sex: String
    
    init(name: String = "", birthday: Date = Date(), deathDate: Date = Date(), age: Int = 0, deathAge: Int = 0, sex: String = "") {
        self.name = name
        self.birthday = birthday
        self.deathDate = deathDate
        self.age = age
        self.deathAge = deathAge
        self.sex = sex
    }
}
    
class ChristmasProperties: ObservableObject {
    var passedDays: Int
    var untilDays: Int
    let daysInThisYear: () -> Int = {
    let calendar = Calendar.current
    let now = Date()
    return calendar.range(of: .day, in: .year, for: now)?.count ?? 0
}
    
    init(passedDays: Int, untilDays: Int) {
        self.passedDays = passedDays
        self.untilDays = untilDays
    }
    
    static func daysUntilChristmas() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        
        guard let christmasDate = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 25)) else {
            print("[daysUntilChristmas] Failed to calculate Christmas date.")
            return 0
        }
        
        if now > christmasDate {
            guard let nextChristmas = calendar.date(from: DateComponents(year: currentYear + 1, month: 12, day: 25)) else {
                return 0
            }
            return calendar.dateComponents([.day], from: now, to: nextChristmas).day ?? 0
        } else {
            // 아직 올해의 크리스마스가 지나지 않았다면 올해 크리스마스까지의 일수를 계산
            return calendar.dateComponents([.day], from: now, to: christmasDate).day ?? 0
        }
        
    }
}



struct InputUserDataView: View {
    @StateObject var userData = UserData()
    
    var body: some View {
        VStack {
            TextField("Enter Name", text: $userData.name)
            DatePicker("Your Birthday", selection: $userData.birthday, displayedComponents: .date)
            TextField("Enter Age", value: $userData.age, formatter: NumberFormatter())
        }
    }
}





//PlaygroundPage.current.setLiveView(InputUserDataView())
