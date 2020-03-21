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

    public lazy var dispatchFunction: DispatchFunction = createDispatchFunction()

    public var middleware: [Middleware<State>] {
        didSet {
            dispatchFunction = self.createDispatchFunction()
        }
    }

    private let lock: NSLock = NSLock()

    public required init(reducer: @escaping Reducer<State>,
                         state: State?,
                         middleware: [Middleware<State>] = [],
                         subscribers: StoreSubscriberProtocol = StoreSubscriber(),
                         options: StoreOptions = []) {
        self.reducer = reducer
        self.subscribers = subscribers
        self.middleware = middleware
        self.options = options
        if let state = state {
            self.state = state
        } else {
            self.dispatch(action: DefaultAction())
        }
    }

    private func createDispatchFunction() -> DispatchFunction {
        return middleware
            .reversed()
            .reduce(
                { [unowned self] action in
                    self._dispatch(action: action)
                },
                { dispatchFunction, middleware in
                    let dispatch: (Action) -> Void = { [weak self] in self?.dispatch(action: $0) }
                    let getState = { [weak self] in self?.state }
                    return middleware(dispatch, getState)(dispatchFunction)
                })
    }

    private func _dispatch(action: Action) {
        lock.lock(); defer { lock.unlock() }
        state = reducer(action, state)
        if let state = state {
            self.subscribers.next(state)
        }
    }

    public func dispatch(action: Action) {
        dispatchFunction(action)
    }
}

extension Store {
    public func subscribe<S: StoreSubscriberType>(_ newSubscriber: S) {
        subscribers.subscribe(newSubscriber)
        if !options.contains(.NoInitialValue), let state = state {
            newSubscriber.newState(state: state)
        }
    }

    public func unSubscribe<S: StoreSubscriberType>(_ subscriber: S) {
        subscribers.unSubscribe(subscriber)
    }
}
