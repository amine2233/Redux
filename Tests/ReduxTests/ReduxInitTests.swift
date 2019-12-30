//
//  ReduxInitTests.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import XCTest
@testable import Redux

class ReduxInitTests: XCTestCase {

    func testInitState() {
        var initState = PlayerState()
        initState.previous(decreaseBy: 9)

        let store = Store<PlayerState>(reducer: TestReducer.appReducer, state: initState, options: [.Once])
        let subscriber = MockSubscriber(name: "subscriber_1")
        store.subscribe(subscriber)

        XCTAssertEqual(subscriber.newStateResult, "previous decreaseBy: 9")

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
