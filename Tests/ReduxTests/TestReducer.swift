//
//  TestReducer.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation
import Redux

struct TestReducer {

    static func appReducer(_ action: Action?, _ state: PlayerState?) -> PlayerState {
        var newState = state ?? PlayerState()

        switch action {
        case let action as Start:
            newState.start(item: action.item)
        case let action as Stop:
            newState.stop(item: action.item)
        case let action as Play:
            newState.play(item: action.item)
        case let action as Next:
            newState.next(increaseBy: action.increaseBy)
        case let action as Previous:
            newState.previous(decreaseBy: action.decreaseBy)
        default:
            break
        }

        return newState
    }
}
