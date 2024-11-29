//
//  AnnualEventsListView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

//HomeView가 지나치게 복잡해지는 일을 방지하기 위해, 연간 이벤트 리스트를 여기에서 선언하고 HomeView에서는 단순 호출만 진행한다.
import SwiftUI

struct EventsListView: View {
    
    @Binding var event: [Event]
    
    var body: some View {

            ForEach(event) { event in
                EventView(eventName: .constant(event.name),
                                dDay: .constant(event.dDay),
                                gaugeValue: .constant(event.gaugeValue),
                                min: .constant(event.min),
                                max: .constant(event.max))
        }
    }
}

#Preview {
    EventsListView(event: .constant(
        [
            Event(name: "New Year", dDay: 5, gaugeValue: 1, min: 1, max: 365),
        Event(name: "Christmas", dDay: 5, gaugeValue: 1, min: 1, max: 365)
    ]
        )
    )
}
