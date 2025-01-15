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
