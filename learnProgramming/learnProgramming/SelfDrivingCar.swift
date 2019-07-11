//
//  SelfDrivingCar.swift
//  learnProgramming
//
//  Created by Jinyung Yoon on 03/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import Foundation

class SelfDrivingCar : Car {
    
    var destination : String?
    
    override func drive() {
        super.drive()
        
        if destination != nil {
         print("driving towards " + destination!)
        }
        
        
    }
}
