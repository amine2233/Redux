//
//  Store.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation

public class Store<State: StateType>: StoreProtocol {
    public private(set) var options: StoreOptions

    public private(set) var reducer: Reducer<State>

    public private(set) var state: State?

    public private(set) var subscribers: StoreSubscriberProtocol

    public required init(reducer: @escaping Reducer<State>,
                         state: State?,
                         subscribers: StoreSubscriberProtocol = StoreSubscriber(),
                         options: StoreOptions = []) {
        self.reducer = reducer
        self.subscribers = subscribers
        self.options = options
        if let state = state {
            self.state = state
        } else {
            self.dispatch(action: DefaultAction())
        }
    }
}

extension Store {

    public func dispatch(action: Action) {
        state = reducer(action, state)
        if let state = state {
            subscribers.next(state)
        }
    }

    public func subscribe(_ newSubscriber: StoreSubscriberType) {
        subscribers.subscribe(newSubscriber)
        if options.contains(.Once), let state = state {
            newSubscriber.newState(state: state)
        }
    }

    public func unSubscribe(_ subscriber: StoreSubscriberType) {
        subscribers.unSubscribe(subscriber)
    }
}
