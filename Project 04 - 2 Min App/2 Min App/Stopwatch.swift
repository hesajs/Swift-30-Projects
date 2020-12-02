//
//  Stopwatch.swift
//  2 Min App
//
//  Created by SaJesh Shrestha on 11/30/20.
//

import Foundation

class Stopwatch: NSObject {
    var counter: Int
    var timer: Timer
    
    override init() {
        counter = 0
        timer = Timer()
    }
}
