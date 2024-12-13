//
//  AnnualEventsListView.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

//HomeView가 지나치게 복잡해지는 일을 방지하기 위해, 연간 이벤트 리스트를 여기에서 선언하고 HomeView에서는 단순 호출만 진행한다.
import SwiftUI



struct EncodedEventsListView: View {
    
    @StateObject var eventList: EventsArray
    
    var body: some View {

        ForEach(eventList.events) { event in
                EventView(eventStore: event)
        }
    }
}

#Preview {
    EncodedEventsListView(eventList: EventsArray())
}
