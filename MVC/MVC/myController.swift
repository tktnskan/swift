//
//  myController.swift
//  MVC
//
//  Created by Jinyung Yoon on 17/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import Foundation

class myController {
    
    let c: Add
    let d: StringConverter
    let myview: ViewController
    let myview2: hi
    
    init(view: ViewController){
        myview = view
        c = Add()
        d = StringConverter()
        myview2 = view
    }
    
    func bCC() {
        myview.changeLbText(a: "bye")
        let a = myview.getText()
        let b = myview.getText2()
        
        let result = c.addNumbers(a: d.stringToInt(a: a), b: d.stringToInt(a: b))
        
        myview.changeLbText(a: String(result))
    }
}
