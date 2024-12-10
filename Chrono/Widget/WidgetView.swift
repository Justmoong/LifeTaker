//
//  WidgetView.swift
//  Chrono
//
//  Created by 윤무영 on 12/10/24.
//

import WidgetKit
import SwiftUI

struct UserDataEntry: TimelineEntry {
    let date: Date
    let userName: String
    let userAge: Int
}

struct UserDataProvider: TimelineProvider {
    func placeholder(in context: Context) -> UserDataEntry {
        UserDataEntry(date: Date(), userName: "John Doe", userAge: 30)
    }

    func getSnapshot(in context: Context, completion: @escaping (UserDataEntry) -> Void) {
        let entry = UserDataEntry(date: Date(), userName: "John Doe", userAge: 30)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<UserDataEntry>) -> Void) {
        let sharedDefaults = UserDefaults(suiteName: "group.com.yourname.yourapp")
        var userName = "Unknown"
        var userAge = 0

        if let data = sharedDefaults?.data(forKey: "UserData") {
            let decoder = JSONDecoder()
            if let userData = try? decoder.decode(UserData.self, from: data) {
                userName = userData.userName
                userAge = userData.userAge
            }
        }

        let entry = UserDataEntry(date: Date(), userName: userName, userAge: userAge)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct UserDataWidgetEntryView: View {
    var entry: UserDataProvider.Entry

    var body: some View {
        VStack {
            Text("Name: \(entry.userName)")
            Text("Age: \(entry.userAge)")
        }
    }
}

struct UserDataWidget: Widget {
    let kind: String = "UserDataWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: UserDataProvider()) { entry in
            UserDataWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("User Data Widget")
        .description("Displays user data.")
    }
}
