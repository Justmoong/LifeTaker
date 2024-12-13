//
//  EventsProperties.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//
import Foundation

class EventsProperties: Identifiable, ObservableObject {
    var id = UUID()
    var name = ""
    var DDay = 5
    var gaugeValue = 1
    var min = 1
    var max = 100
    
    private let chronoCalendar = ChronoCalendar()

    static func calculateTotalMondays() -> Int {
            let chronoCalendar = ChronoCalendar()
            let userBirthDay = UserDefaults.standard.object(forKey: "userBirthDay") as? Date ?? Date()
            let expectedLifespan = UserDefaults.standard.integer(forKey: "expectedLifespan")
            
            guard let deathDate = chronoCalendar.addYears(to: userBirthDay, years: expectedLifespan) else {
                return 0
            }
            return chronoCalendar.calculateMondays(from: userBirthDay, to: deathDate)
        }

        static func calculatePastMondays() -> Int {
            let chronoCalendar = ChronoCalendar()
            let userBirthDay = UserDefaults.standard.object(forKey: "userBirthDay") as? Date ?? Date()
            let now = Date()
            return chronoCalendar.calculateMondays(from: userBirthDay, to: now)
        }

}
