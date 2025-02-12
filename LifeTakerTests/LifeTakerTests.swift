//
//  ChronoTests.swift
//  ChronoTests
//
//  Created by 윤무영 on 12/5/24.
//

import Foundation
import XCTest

@testable import Life_Taker

final class ChronoTests: XCTestCase {

    func testHelloWorld_ConstString_ConstString() {
        //PreCondition
        let message = "Hello, Swift!"
        //Action
        func chString (what: String) -> String {
           let content = "Hello, World!"
            return content
        }
        print(#function,chString(what: message))
        //PostCondition && Assert
        XCTAssertEqual(chString(what: message), "Hello, World!")
    }
    
    func testSetBirthDay_DateComponent_String() {
        //PreCondition
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2002
        dateComponents.month = 5
        dateComponents.day = 4
        //Action
        let resultDate = Calendar.current.date(from: dateComponents)

        print(#function, dateFormatter.string(from: resultDate!))
        //PostCondition && Assert
        XCTAssert(resultDate != nil)
    }


}
