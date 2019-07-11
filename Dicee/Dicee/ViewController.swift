//
//  ViewController.swift
//  Dicee
//
//  Created by Jinyung Yoon on 24/06/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var randomDiceIndex1: Int = 1
    var randomDiceIndex2: Int = 1
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomDice()
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        getRandomDice()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        getRandomDice()
    }
    
    func getRandomDice() {
        randomDiceIndex1 = Int.random(in: 1 ... 6)
        randomDiceIndex2 = Int.random(in: 1 ... 6)
        
        let img1 = "dice" + String(randomDiceIndex1)
        let img2 = "dice" + String(randomDiceIndex2)
        
        result.text = String( randomDiceIndex2 + randomDiceIndex1)
        
        diceImageView1.image = UIImage(named: img1)
        
        diceImageView2.image = UIImage(named: img2)
    }
    

}

