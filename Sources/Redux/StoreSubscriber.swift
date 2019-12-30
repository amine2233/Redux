//
//  StoreSubscriber.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation

public protocol StoreSubscriberType {
    var name: String { get }
    func newState<State: StateType>(state: State?)
}

extension StoreSubscriberType {
    var name: String {
        return String(describing: self)
    }
}
