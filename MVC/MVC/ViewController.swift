//
//  ViewController.swift
//  MVC
//
//  Created by Jinyung Yoon on 17/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

protocol clickable {
    func onClick()
}


class MyImg:clickable{
    func onClick() {
        
    }
}

class MyVideo:clickable{
    func onClick() {
        print("video")
    }
}

class MyText:clickable{
    func onClick() {
        print("text")
    }
}


class ViewController: UIViewController{
    
    func test(){
        
        
        var a: [clickable] = [MyText(), MyImg(), MyVideo()]
        
        a[0].onClick()
        
    }
    
    private let text: UITextField = {
        let tt = UITextField()
        tt.clearButtonMode = .whileEditing
        tt.text = ""
        tt.placeholder = "입력"
        tt.translatesAutoresizingMaskIntoConstraints = false
        
        return tt
    }()
    
    private let text2: UITextField = {
        let tt2 = UITextField()
        tt2.clearButtonMode = .whileEditing
        tt2.text = ""
        tt2.placeholder = "입력"
        tt2.translatesAutoresizingMaskIntoConstraints = false
        
        return tt2
    }()
    
    private let label: UILabel = {
        let lb = UILabel()
        lb.text = "hi"
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    private let button: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("button", for: .normal)
        bt.setTitleColor(.red, for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        addTarget()
    }
    
    private func setupUI() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(text)
        view.addSubview(text2)
        
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        text2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        text2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func getText() -> String {
        let tot = text.text!
        
        return tot
    }
    
    func getText2() -> String {
        let tot2 = text2.text!
        
        return tot2
    }
    
    public func changeLbText(a: String) {
        label.text = a
    }
    
    internal lazy var hi: myController = { myController(view: self) }()
    
    @objc
    private func userClickButton() {
        hi.bCC()
    }

    private func addTarget() {
        button.addTarget(self, action: #selector(userClickButton), for: .touchUpInside)
    }
}

