//
//  StoreSubscriberProtocol.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation

public protocol StoreSubscriberProtocol {

    func next<State: StateType>(_ state: State)
    func subscribe(_ newSubscriber: StoreSubscriberType)
    func unSubscribe(_ subscriber: StoreSubscriberType)
}

public class StoreSubscriber: StoreSubscriberProtocol {

    private var array: [StoreSubscriberType]

    public init(array: [StoreSubscriberType] = []) {
        self.array = array
    }

    public func next<State: StateType>(_ state: State) {
        array.forEach { $0.newState(state: state) }
    }

    public func subscribe(_ newSubscriber: StoreSubscriberType) {
        array.append(newSubscriber)
    }

    public func unSubscribe(_ subscriber: StoreSubscriberType) {
        guard let index = array.firstIndex(where: { return $0.name == subscriber.name }) else {
            return
        }
        array.remove(at: index)
    }
}
