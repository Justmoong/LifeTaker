//
//  InputView.swift
//  Chrono
//
//  Created by ymy on 1/27/25.
//

import SwiftUI

struct InputView: View {
    
    @StateObject var userData = UserData()
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isCalcAuto") private var isCalcAuto: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $userData.name)
                    Toggle("Auto Calculate", isOn: $isCalcAuto)
                        .tint(.accentColor)
                    DatePicker("Birthday", selection: $userData.birthday, displayedComponents: .date)
                    DatePicker("Death Date", selection: $userData.deathDate, displayedComponents: .date)
                }
            }
            .navigationTitle("About You")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        userData.setAge()
                        if isCalcAuto {
                            userData.setDeathDate()
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    InputView()
}
