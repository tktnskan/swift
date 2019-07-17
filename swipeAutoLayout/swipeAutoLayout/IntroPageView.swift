//
//  IntroPage.swift
//  swipeAutoLayout
//
//  Created by Jinyung Yoon on 17/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

private let WeatherApiButton: UIButton = {
    let wab = UIButton(type: .system)
    wab.setTitle("Check Weatehr", for: .normal)
    wab.setTitleColor(.purple, for: .normal)
    wab.translatesAutoresizingMaskIntoConstraints = false
    
    return wab
}()


class IntroPageView: UIView {
    
    override func addSubview(_ view: UIView) {
        view.addSubview(WeatherApiButton)
        
        WeatherApiButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        WeatherApiButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}

