//
//  File.swift
//  ReSwift Todo List
//
//  Created by Adrian Wisaksana on 3/14/17.
//  Copyright © 2017 Adrian Wisaksana. All rights reserved.
//

import ReSwift

let loggingMiddleware: Middleware = { (dispatch, getState) in
    return { (next) in
        return { (action) in
            print("\n")
            print(action)
            return next(action)
        }
    }
}
