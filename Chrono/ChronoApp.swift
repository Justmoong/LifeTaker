//
//  Regret_VaccineApp.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

@main
struct ChronoApp: App {
    
        //        let schema = Schema([
        //            Item.self,
        //        ])
        //        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        //
        //        do {
        //            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        //        } catch {
        //            fatalError("Could not create ModelContainer: \(error)")
        //        }
        //    }()
        
    var body: some Scene {
            WindowGroup {
                HomeView()
            }

        }
    }


