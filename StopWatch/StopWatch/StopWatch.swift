//
//  StopWatch.swift
//  StopWatch
//
//  Created by Jinyung Yoon on 23/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
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
