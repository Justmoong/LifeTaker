//
//  InputView.swift
//  Chrono
//
//  Created by ymy on 1/27/25.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isCalcAuto") private var isCalcAuto: Bool = false
    
    @StateObject private var healthManager = HealthManager.shared
    @State private var showHealthKitAlert = false
    @State private var healthKitAlertMessage = ""
    
    @StateObject private var locationManager = CoreLocation()
    @State private var showLocationAlert = false
    @State private var locationAlertMessage = ""
    
    @EnvironmentObject var monthCount: MonthCount
    @EnvironmentObject var weekCount: WeekCount
    @EnvironmentObject var dayCount: DayCount
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $userData.name)
                    
                    DatePicker("Birthday", selection: $userData.birthday, displayedComponents: .date)
                    DatePicker("End Date", selection: $userData.deathDate, displayedComponents: .date)
                        .tint(isCalcAuto ? .secondary : .primary)
                        .opacity(isCalcAuto ? 0.25 : 1)
                        .disabled(isCalcAuto)
                }
                Section {
                    Toggle("Auto Calculate", isOn: $isCalcAuto)
                        .tint(.accentColor)
                }
                if isCalcAuto {
                    Section(footer: Text(healthKitFooter())) {
                        Picker("Select Sex", selection: $userData.sex) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        HStack {
                            Text("Heart Rate: ")
                            Spacer()
                            Text("\(Int(healthManager.heartRate ?? 0)) bpm")
                                .foregroundStyle(Color.accentColor)
                        }
                        HStack {
                            Text("Step Count:")
                            Spacer()
                            Text("\(Int(healthManager.stepCount ?? 0)) steps")
                                .foregroundStyle(Color.accentColor)
                        }
                        HStack {
                            Text("Active Calories: ")
                            Spacer()
                            Text("\(Int(healthManager.activeCalories ?? 0)) kcal")
                                .foregroundStyle(Color.accentColor)
                        }
                        HStack {
                            Text("Sleep Duration: ")
                            Spacer()
                            Text(healthManager.formatSleepDuration(healthManager.sleepDuration ?? 0))
                                .foregroundStyle(Color.accentColor)
                        }
                        Button("Import Health Data") {
                            healthManager.requestHealthKitPermission { success in
                                if success {
                                    healthManager.fetchHeartRateData { heartRate in
                                        if let heartRate = heartRate, heartRate > 0 {
                                            print("Fetched Heart Rate: \(heartRate) bpm")
                                        } else {
                                            healthKitAlertMessage = "Failed to fetch heart rate data."
                                            showHealthKitAlert = true
                                        }
                                    }
                                    healthManager.fetchStepCountData { stepCount in
                                        if let stepCount = stepCount, stepCount > 0 {
                                            print("Fetched Step Count: \(stepCount) steps")
                                        } else {
                                            healthKitAlertMessage = "Failed to fetch step count data."
                                            showHealthKitAlert = true
                                        }
                                    }
                                    healthManager.fetchActiveCaloriesData { activeCalories in
                                        if let activeCalories = activeCalories, activeCalories > 0 {
                                            print("Fetched Active Calories: \(activeCalories) kcal")
                                        } else {
                                            healthKitAlertMessage = "Failed to fetch active calories data."
                                            showHealthKitAlert = true
                                        }
                                    }
                                    healthManager.fetchSleepData { sleepDuration in
                                        if let sleepDuration = sleepDuration, sleepDuration > 0 {
                                            print("Fetched Sleep Duration: \(sleepDuration)")
                                        } else {
                                            healthKitAlertMessage = "Failed to fetch your sleep data."
                                            showHealthKitAlert = true
                                        }
                                    }
                                } else {
                                    healthKitAlertMessage = "HealthKit access was denied. Please enable access in Settings."
                                    showHealthKitAlert = true
                                }
                                healthManager.saveToUserDefaults()
                            } //Button - HealthKit
                        }
                        .alert(isPresented: $showHealthKitAlert) {
                            Alert(
                                title: Text("Health Data Error"),
                                message: Text(healthKitAlertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    Section(footer: Text(locationFooter())) {
                        HStack {
                            Text("Current Location: ")
                            Spacer()
                            Text("\(locationManager.continent ?? "N/A")")
                                .foregroundStyle(Color.accentColor)
                        }
                        Button("Import Location Data") {
                            locationManager.requestLocationPermission()
                            print("\(locationManager.location), \(locationManager.continent)")
                        }
                    }
                }
            }
            .navigationTitle("About You")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        if isCalcAuto {
                            userData.setDeathDate(with: locationManager)
                        }
                        monthCount.calculateMonths(from: userData)
                        weekCount.calculateWeeks(from: userData)
                        dayCount.calculateDays(from: userData)
                        userData.setAge()
                        userData.saveToUserDefaults()
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            healthManager.loadFromUserDefaults()
            locationManager.loadFromUserDefaults()
        }
    }
    
    private func healthKitFooter() -> AttributedString {
        var fullText = AttributedString("The data from the Health app is used to calculate the expected life of the user.\nUse the records of the last year to check the health status of the user.")
        
        if let range = fullText.range(of: "Health") {
            fullText[range].foregroundColor = .blue
            fullText[range].underlineStyle = .single
            fullText[range].link = URL(string: "x-apple-health://browse")
        }
        
        return fullText
    }
    
    private func locationFooter() -> AttributedString {
        var fullText = AttributedString("The calculation incorporates statistical data provided by the World Health Organization (WHO) to estimate life expectancy based on global health trends.\nLearn more about the WHO's data...")
        
        if let range = fullText.range(of: "Learn more about the WHO's data...") {
            fullText[range].foregroundColor = .blue
            fullText[range].underlineStyle = .single
            fullText[range].link = URL(string: "https://data.who.int/countries")
        }
        
        return fullText
    }
}
    
#Preview {
    InputView()
        .environmentObject(UserData())
        .environmentObject(MonthCount(viewModel: UserData()))
        .environmentObject(WeekCount(viewModel: UserData()))
        .environmentObject(DayCount(viewModel: UserData()))
}
