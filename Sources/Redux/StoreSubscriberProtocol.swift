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
    @discardableResult
    func unSubscribe(_ subscriber: StoreSubscriberType) -> StoreSubscriberType?
}

public class StoreSubscriber: StoreSubscriberProtocol {

    private var array: [StoreSubscriberType]

    public init(_ array: [StoreSubscriberType] = []) {
        self.array = array
    }

    public func next<State: StateType>(_ state: State) {
        array.forEach { $0.newState(state: state) }
    }

    public func subscribe(_ newSubscriber: StoreSubscriberType) {
        array.append(newSubscriber)
    }

    @discardableResult
    public func unSubscribe(_ subscriber: StoreSubscriberType) -> StoreSubscriberType? {
        guard let index = array.firstIndex(where: { return $0.name == subscriber.name }) else {
            return nil
        }
        return array.remove(at: index)
    }
}
