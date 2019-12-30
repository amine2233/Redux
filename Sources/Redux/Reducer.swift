//
//  Reducer.swift
//  Redux
//
//  Created by Amine Bensalah on 30/12/2019.
//

import Foundation

public typealias Reducer<StateType> = (_ action: Action, _ state: StateType?) -> StateType
