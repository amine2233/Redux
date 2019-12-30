//
//  PlayerState.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation
import Redux

struct PlayerState: StateType {
    var name: String?

    init() {
        name = "play init"
    }

    mutating func play(item: Int) {
        name = "play item: \(item)"
    }

    mutating func stop(item: Int) {
        name = "stop item: \(item)"
    }

    mutating func start(item: Int) {
        name = "start item: \(item)"
    }

    mutating func next(increaseBy: Int) {
        name = "next increaseBy: \(increaseBy)"
    }

    mutating func previous(decreaseBy: Int) {
        name = "previous decreaseBy: \(decreaseBy)"
    }
}
