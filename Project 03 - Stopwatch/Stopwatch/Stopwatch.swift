//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by SaJesh Shrestha on 11/4/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
