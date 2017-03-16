//
//  AppDelegate.swift
//  ReSwift Todo List
//
//  Created by Adrian Wisaksana on 3/14/17.
//  Copyright © 2017 Adrian Wisaksana. All rights reserved.
//

import UIKit
import ReSwift

// create store with `AppReducer` instance
let store = Store<AppState>(reducer: AppReducer(), state: nil, middleware: [loggingMiddleware])

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    var window: UIWindow?

}

