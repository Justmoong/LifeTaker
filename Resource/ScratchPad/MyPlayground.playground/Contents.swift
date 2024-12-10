import SwiftUI
import Foundation

// Seperate Data Model User/Date Both Models
class DateCount: ObservableObject, Codable {
    @Published var yearCount: Int
    @Published var monthCount: Int
    @Published var dayCount: Int
    @Published var hourCount: Int
    @Published var minCount: Int
    @Published var secCount: Int
    
    init(yearCount: Int, monthCount: Int, dayCount: Int, hourCount: Int, minCount: Int, secCount: Int) {
        self.yearCount = yearCount
        self.monthCount = monthCount
        self.dayCount = dayCount
        self.hourCount = hourCount
        self.minCount = minCount
        self.secCount = secCount
    }
    
    // Custom encoder/decoder to handle @Published properties
    private enum CodingKeys: String, CodingKey {
        case yearCount, monthCount, dayCount, hourCount, minCount, secCount
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        yearCount = try container.decode(Int.self, forKey: .yearCount)
        monthCount = try container.decode(Int.self, forKey: .monthCount)
        dayCount = try container.decode(Int.self, forKey: .dayCount)
        hourCount = try container.decode(Int.self, forKey: .hourCount)
        minCount = try container.decode(Int.self, forKey: .minCount)
        secCount = try container.decode(Int.self, forKey: .secCount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(yearCount, forKey: .yearCount)
        try container.encode(monthCount, forKey: .monthCount)
        try container.encode(dayCount, forKey: .dayCount)
        try container.encode(hourCount, forKey: .hourCount)
        try container.encode(minCount, forKey: .minCount)
        try container.encode(secCount, forKey: .secCount)
    }
}

class UserData: ObservableObject, Codable {
    @Published var userName: String
    @Published var userSex: String
    @Published var userAge: Int
    @Published var userBirthday: Date
    @Published var userDeathAge: Int
    @Published var userExpectedLifespan: Int

    init(userName: String, userSex: String, userAge: Int, userBirthday: Date, userDeathAge: Int, userExpectedLifespan: Int) {
        self.userName = userName
        self.userSex = userSex
        self.userAge = userAge
        self.userBirthday = userBirthday
        self.userDeathAge = userDeathAge
        self.userExpectedLifespan = userExpectedLifespan
    }
    
    // Custom encoder/decoder to handle @Published properties
    private enum CodingKeys: String, CodingKey {
        case userName, userSex, userAge, userBirthday, userDeathAge, userExpectedLifespan
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userName = try container.decode(String.self, forKey: .userName)
        userSex = try container.decode(String.self, forKey: .userSex)
        userAge = try container.decode(Int.self, forKey: .userAge)
        userBirthday = try container.decode(Date.self, forKey: .userBirthday)
        userDeathAge = try container.decode(Int.self, forKey: .userDeathAge)
        userExpectedLifespan = try container.decode(Int.self, forKey: .userExpectedLifespan)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userName, forKey: .userName)
        try container.encode(userSex, forKey: .userSex)
        try container.encode(userAge, forKey: .userAge)
        try container.encode(userBirthday, forKey: .userBirthday)
        try container.encode(userDeathAge, forKey: .userDeathAge)
        try container.encode(userExpectedLifespan, forKey: .userExpectedLifespan)
    }
}

//InputUserInfoView에 해당
struct InputView: View {
    
    @Binding var inputedName: String
    @Binding var inputedUserBirthday: Date
        
    var body: some View {
        TextField("Enter Name", text: $inputedName)
        DatePicker("Your Birthday :", selection: $inputedUserBirthday)
    }
}

//UserProfileView나 EventView에 해당하는 것
struct DisplayView: View {
    
    @StateObject var userDataModel: UserData
    
    var body: some View {
        
        Text("Hello, World!")
        Text("\(userDataModel.userAge)")
        Text("\(userDataModel.userBirthday)")
    }
}

//HomeView에 해당
struct ContentsView: View {
    
    @StateObject private var userDataModel = UserData(userName: "", userSex: "", userAge: 0, userBirthday: Date(), userDeathAge: 80, userExpectedLifespan: 80)
    @StateObject private var dateCounter = DateCount(yearCount: 0, monthCount: 0, dayCount: 0, hourCount: 0, minCount: 0, secCount: 0)
    
    var body: some View {
        VStack {
            InputView(inputedName: $userDataModel.userName, inputedUserBirthday: $userDataModel.userBirthday)
            DisplayView(userDataModel: userDataModel)
        }
    }
}

let calendar = Calendar.current
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"


let appGroup = "group.com.moonglab.chrono"
let sharedDefaults = UserDefaults(suiteName: appGroup)

@MainActor func saveUserData(userData: UserData) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(userData) {
        sharedDefaults?.set(encoded, forKey: "UserData")
    }
}

@MainActor func loadUserData() -> UserData? {
    if let data = sharedDefaults?.data(forKey: "UserData") {
        let decoder = JSONDecoder()
        return try? decoder.decode(UserData.self, from: data)
    }
    return nil
}
