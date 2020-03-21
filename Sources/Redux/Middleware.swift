//
//  Middleware.swift
//  Redux
//
//  Created by Amine Bensalah on 21/03/2020.
//

import Foundation

public typealias DispatchFunction = (Action) -> Void
public typealias Middleware<StateType> = (@escaping DispatchFunction, @escaping () -> StateType?) -> (@escaping DispatchFunction) -> DispatchFunction
