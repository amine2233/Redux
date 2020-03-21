//
//  Redux_iOSTests.swift
//  Redux iOSTests
//
//  Created by Amine Bensalah on 30/12/2019.
//

import XCTest
@testable import Redux

private let printMiddleware: Middleware<PlayerState> = { dispatch, getState in
    return { next in
        return { action in
            print("==============================")
            print("\(action), Action dispatched.")
            next(action)
            print("new state: \n\(String(describing: getState()))")
            print("==============================")
            print()
            return
        }
    }
}

class ReduxTests: XCTestCase {

    var store: Store<PlayerState>!
    var subscriber: MockSubscriber!

    override func setUp() {
        super.setUp()
        self.store = Store(reducer: TestReducer.appReducer,
                           state: nil,
                           middleware: [printMiddleware],
                           options: [.Once])
        self.subscriber = MockSubscriber(name: "subscriber_1")
        self.store.subscribe(self.subscriber)
    }

    override func tearDown() {
        super.tearDown()
        self.store = nil
        self.subscriber = nil
    }

    func testInitState() {
        XCTAssertEqual(subscriber.newStateResult, "play init")
    }

    func testPlayState() {
        store.dispatch(action: Play(item: 6))
        XCTAssertEqual(subscriber.newStateResult, "play item: 6")
    }

    func testUnscubscribe() {

        store.dispatch(action: Stop(item: 2))
        let newSubscribe = MockSubscriber(name: "subscriber_2")
        store.subscribe(newSubscribe)
        XCTAssertEqual(newSubscribe.newStateResult, "stop item: 2")
        store.unSubscribe(newSubscribe)

        store.dispatch(action: Next(increaseBy: 3))
        XCTAssertEqual(newSubscribe.newStateResult, "stop item: 2")
        XCTAssertEqual(subscriber.newStateResult, "next increaseBy: 3")
    }

    func testUnscribeNotFoundObject() {
        let newSubscribe = MockSubscriber(name: "subscriber_3")
        store.dispatch(action: Start(item: 2))
        XCTAssertNil(newSubscribe.newStateResult)
        store.unSubscribe(newSubscribe)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
