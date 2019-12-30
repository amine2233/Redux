//
//  Action.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation
import Redux

struct Start: Action {
    let item: Int
}

struct Stop: Action {
    let item: Int
}

struct Play: Action {
    let item: Int
}

struct Next: Action {
    let increaseBy: Int
}

struct Previous: Action {
    let decreaseBy: Int
}
