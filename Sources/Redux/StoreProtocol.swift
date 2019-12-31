//
//  StoreProtocol.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation

public struct StoreOptions: OptionSet {
    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let NoInitialValue = StoreOptions(rawValue: 1)

    public static let Once = StoreOptions(rawValue: 2)
}

public protocol StoreProtocol: class {
    associatedtype State: StateType

    var options: StoreOptions { get }
    var reducer: Reducer<State> { get }
    var state: State? { get }
    var subscribers: StoreSubscriberProtocol { get }

    init(reducer: @escaping Reducer<State>, state: State?, subscribers: StoreSubscriberProtocol, options: StoreOptions)

    func dispatch(on dispatch: DispatchQueue, action: Action)
}
