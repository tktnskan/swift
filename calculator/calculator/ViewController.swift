//
//  ViewController.swift
//  calculator
//
//  Created by Jinyung Yoon on 18/06/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var opIsOn = false
    var op = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.text = ""
    }

    @IBAction func numberpressed(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        
        
        if opIsOn == true {
            opIsOn = false
            
            if tag == 101 {
                if resultLabel.text != "0" {
                    resultLabel.text = resultLabel.text! + String(0) + String(0)
                    numberOnScreen = Double(resultLabel.text!)!
                }
            } else if tag == 1 {
                if resultLabel.text != "0" {
                    resultLabel.text = resultLabel.text! + String(0)
                    numberOnScreen = Double(resultLabel.text!)!
                }
            } else {
                if resultLabel.text == "0" {
                    resultLabel.text = String(tag - 1)
                } else {
                    resultLabel.text = resultLabel.text! + String(tag - 1)
                }
                numberOnScreen = Double(resultLabel.text!)!
            }
        } else {
            if tag == 101 {
                if resultLabel.text != "0" {
                    resultLabel.text = resultLabel.text! + String(0) + String(0)
                    numberOnScreen = Double(resultLabel.text!)!
                }
            } else if tag == 1 {
                if resultLabel.text != "0" {
                    resultLabel.text = resultLabel.text! + String(0)
                    numberOnScreen = Double(resultLabel.text!)!
                }
            } else {
                if resultLabel.text == "0" {
                    resultLabel.text = String(tag - 1)
                } else {
                    resultLabel.text = resultLabel.text! + String(tag - 1)
                }
                numberOnScreen = Double(resultLabel.text!)!
            }
        }
    }
    
    @IBAction func oppressed(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        
        if tag == 16 {
            resultLabel.text = "0"
            previousNumber = 0
            numberOnScreen = 0
            op = 0
            return
        }
        
        if tag == 12 {
            opIsOn = true
            if resultLabel.text == "" {
                resultLabel.text = ""
            } else {
                previousNumber = Double(resultLabel.text!)!
                resultLabel.text = ""
            }
            op = tag
        } else if tag == 13 {
            opIsOn = true
            if resultLabel.text == "" {
                resultLabel.text = ""
            } else {
                previousNumber = Double(resultLabel.text!)!
                resultLabel.text = ""
            }
            op = tag
        } else if tag == 14 {
            opIsOn = true
            if resultLabel.text == "" {
                resultLabel.text = ""
            } else {
                previousNumber = Double(resultLabel.text!)!
                resultLabel.text = ""
            }
            op = tag
        } else if tag == 15 {
            opIsOn = true
            if resultLabel.text == "" {
                resultLabel.text = ""
            } else {
                previousNumber = Double(resultLabel.text!)!
                resultLabel.text = ""
            }
            op = tag
        } else if tag == 17 {
            if Double(resultLabel.text!)! > 0 {
                resultLabel.text = "-" + resultLabel.text!
            } else {
                resultLabel.text = String(-Double(resultLabel.text!)!)
            }
        } else if tag == 18 {
            if resultLabel.text != "0" {
                resultLabel.text = String(Double(resultLabel.text!)! / 100)
            }
        } else if tag == -1 {
            resultLabel.text = resultLabel.text! + "."
        } else if tag == 20 {
            if op == 12 {
                resultLabel.text = String(previousNumber + numberOnScreen)
            } else if op == 13 {
                resultLabel.text = String(previousNumber - numberOnScreen)
            } else if op == 14 {
                resultLabel.text = String(previousNumber * numberOnScreen)
            } else if op == 15 {
                resultLabel.text = String(previousNumber / numberOnScreen)
            }
        }
    }
    
}

