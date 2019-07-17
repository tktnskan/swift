//
//  ViewController.swift
//  swipeAutoLayout
//
//  Created by Jinyung Yoon on 05/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit


private var WeatherApiButton: UIButton = {
    let wab = UIButton(type: .system)
    wab.setTitle("Check Weather", for: .normal)
    wab.setTitleColor(.purple, for: .normal)
    wab.layer.borderWidth = 3
    wab.layer.borderColor = UIColor.black.cgColor
    wab.frame.size = CGSize(width: 200, height: 40)
    wab.layer.cornerRadius = 5
    wab.translatesAutoresizingMaskIntoConstraints = false
    
    return wab
}()

private var label: UILabel = {
    let lb = UILabel()
    lb.text = "Swift"
    lb.font = UIFont(name: lb.font.fontName, size: 20)
    lb.frame.size = CGSize(width: UIView().frame.width, height: 40)
    lb.translatesAutoresizingMaskIntoConstraints = false
    
    return lb
}()


class IntroController: UIViewController {
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        SetUI()
        
        addTargets()
        
    }
    
    private func SetUI() {
        view.addSubview(WeatherApiButton)
        view.addSubview(label)
        
        WeatherApiButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15).isActive = true
        WeatherApiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        WeatherApiButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: view.frame.width / 2 - WeatherApiButton.frame.width / 2, bottom: 15, right: view.frame.width / 2 - WeatherApiButton.frame.width / 2)
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func addTargets() {
        WeatherApiButton.addTarget(self, action: #selector(userClickWeather), for: .touchUpInside)
        
    }
    
    @objc
    private func userClickWeather() {
        let targetVC = FirstPage()
        
        present(targetVC, animated: true, completion: nil)
    }
    
}

//private var introView: UIImageView! = {
//    let iV = UIImageView()
//    iV.translatesAutoresizingMaskIntoConstraints = false
//    return iV
//}()


