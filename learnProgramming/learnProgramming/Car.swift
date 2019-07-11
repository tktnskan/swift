//
//  Car.swift
//  learnProgramming
//
//  Created by Jinyung Yoon on 03/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import Foundation

enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    var colour = "Black"
    var numberOfSeats = 5
    var typeOfCar : CarType = .Coupe
    
    init(){
    }
    
    convenience init(decideColourofCar:String){
        self.init()
        colour = decideColourofCar
    }
    
    func drive() {
        print("car is moving")
    }
}

