//
//  TestView.swift
//  Chrono
//
//  Created by 윤무영 on 10

import SwiftUI

struct TestView: View {
    @State private var birthday = "2002-05-04"
    @State private var lifeExpectancy: Double = 80
    @State private var remainingMondays: Int?

    var body: some View {
        VStack {
//            TextField("생일 (yyyy-MM-dd)", text: $birthday)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            HStack {
//               Text("기대 수명:")
//                  Slider(value: $lifeExpectancy, in: 0...120, step: 1)
//                Text("\(Int(lifeExpectancy))")
//            }
//            .padding()

            Button(action: {
                remainingMondays = calculateRemainingMondays(birthday: birthday, lifeExpectancy: Int(lifeExpectancy))
            }) {
                Text("남은 월요일 계산")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            if let mondays = remainingMondays {
                Text("Remaining Mondays: \(mondays)")
                    .padding()
            } else {
                Text("Press Button")
                    .padding()
            }
        }
        .padding()
    }

    func calculateRemainingMondays(birthday: String, lifeExpectancy: Int) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let birthDate = dateFormatter.date(from: birthday) else {
            return nil
        }
        
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .year, value: lifeExpectancy, to: birthDate)!
        
        var mondaysCount = 0
        var currentDate = Date()
        
        while currentDate <= endDate {
            if calendar.component(.weekday, from: currentDate) == 2 { // 월요일은 2
                mondaysCount += 1
            }
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return mondaysCount
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
