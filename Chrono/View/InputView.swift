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
                    Section {
                        Picker("Select Sex", selection: $userData.sex) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        Button("Import Health Data") {
                            healthManager.requestHealthKitPermission { success in
                                if success {
                                    healthManager.fetchHeartRateData { heartRate in
                                        if let heartRate = heartRate, heartRate > 0 {
                                            print("Fetched Heart Rate: \(heartRate) bpm")
                                        } else {
                                            healthKitAlertMessage = "Failed to fetch heart rate data. Please ensure HealthKit permissions are granted and there is valid data."
                                            showHealthKitAlert = true
                                        }
                                    }
                                } else {
                                    healthKitAlertMessage = "HealthKit access was denied. Please enable access in Settings."
                                    showHealthKitAlert = true
                                }
                            }
                        }
                        .alert(isPresented: $showHealthKitAlert) {
                            Alert(
                                title: Text("Health Data Error"),
                                message: Text(healthKitAlertMessage),
                                dismissButton: .default(Text("OK"))
                            )
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
                            userData.setDeathDate()
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
    }
}

#Preview {
    InputView()
        .environmentObject(UserData())
        .environmentObject(MonthCount(viewModel: UserData()))
        .environmentObject(WeekCount(viewModel: UserData()))
        .environmentObject(DayCount(viewModel: UserData()))
}
