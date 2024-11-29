//
//  AnnualEventsListView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

//HomeView가 지나치게 복잡해지는 일을 방지하기 위해, 연간 이벤트 리스트를 여기에서 선언하고 HomeView에서는 단순 호출만 진행한다.
import SwiftUI

struct AnnualEventsListView: View {
    
    @Binding var event: [AnnualEvent]
    
    var body: some View {

            ForEach(event) { event in
                AnnualEventView(eventName: .constant(event.name),
                                progressValue: .constant(event.progressValue),
                                min: .constant(event.min),
                                max: .constant(event.max))
        }
    }
}

#Preview {
    AnnualEventsListView(event: .constant(
        [
        AnnualEvent(name: "New Year", progressValue: 1, min: 1, max: 365),
        AnnualEvent(name: "Christmas", progressValue: 1, min: 1, max: 365)
    ]
        )
    )
}
