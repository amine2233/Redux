//
//  MockSubscriber.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation
import Redux

class MockSubscriber: StoreSubscriberType {
    var newStateResult: String?

    var name: String

    init(name: String) {
        self.name = name
    }

    func newState<State>(state: State?) where State : StateType {
        if let state = state as? PlayerState {
            self.newStateResult = state.name
        }
    }
}
