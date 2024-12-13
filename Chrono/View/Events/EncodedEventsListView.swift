//
//  AnnualEventsListView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

//HomeView가 지나치게 복잡해지는 일을 방지하기 위해, 연간 이벤트 리스트를 여기에서 선언하고 HomeView에서는 단순 호출만 진행한다.
import SwiftUI

class EventsProperties: Identifiable, ObservableObject {
    var id = UUID()
    var name: String
    var DDay: Int
    var gaugeValue: Int
    var min: Int
    var max: Int
    
    init(name: String, DDay: Int, gaugeValue: Int, min: Int, max: Int) {
        self.name = name
        self.DDay = DDay
        self.gaugeValue = gaugeValue
        self.min = min
        self.max = max
    }
    
    // MARK: - Monday
    public static func calculateTotalMondays() -> Int {
        let userBirthDay = UserDefaults.standard.object(forKey: "userBirthDay") as? Date ?? Date()
        let expectedLifespan = UserDefaults.standard.integer(forKey: "expectedLifespan")
        
        let calendar = Calendar.current
        guard let deathDate = calendar.date(byAdding: .year, value: expectedLifespan, to: userBirthDay) else {
            return 0
        }
        print("Debug info: [calculateTotalMondays].userBirthDay set:\(userBirthDay)")
        print("Debug info: [calculateTotalMondays].deathDate set:\(deathDate)")
        
        var totalMondays = 0
        var date = userBirthDay
        while date <= deathDate {
            if calendar.component(.weekday, from: date) == 2 { // 월요일
                totalMondays += 1
            }
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        return totalMondays
    }

    // 지금까지 지난 월요일의 수를 계산 gaugeValue
    public static func calculatePastMondays() -> Int {
        let userBirthDay = UserDefaults.standard.object(forKey: "userBirthDay") as? Date ?? Date()
        let now = Date()
        let calendar = Calendar.current
        
        var pastMondays = 0
        var date = userBirthDay
        while date <= now {
            if calendar.component(.weekday, from: date) == 2 { // 월요일
                pastMondays += 1
            }
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        return pastMondays
    }

}



class EventsList: ObservableObject {
    @Published var events: [EventsProperties] = []
    
    init(events: [EventsProperties] = []) {
        self.events = events
    }
}

struct EncodedEventsListView: View {
    
    @StateObject var eventList: EventsList
    
    var body: some View {

        ForEach(eventList.events) { event in
                EventView(eventStore: event)
        }
    }
}

#Preview {
    EncodedEventsListView(eventList: EventsList())
}
