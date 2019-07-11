//
//  ViewController.swift
//  board
//
//  Created by Jinyung Yoon on 04/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    private let text: UITextField = {
        let tt = UITextField()
        tt.frame = CGRect(x: 70, y: 120, width: 200, height: 30)
        tt.backgroundColor = .white
        
        tt.keyboardType = UIKeyboardType.alphabet
        return tt
    }()
    
    private let button: UIButton = {
        let bt = UIButton(type: .system)
        let articles = ArticleBank()
        bt.frame = CGRect(x: 70, y: 60, width: 200, height: 30)
        bt.setTitle("01: " + articles.articleList[0].title, for: .normal)
        bt.tag = 0
        return bt
    }()
    
    @objc
    private func userDidClickOnButton(_ sender: UIButton) {
        print("hi")
        let secondVC = SecondViewController()
        let articleDetail = ArticleBank()
        let articleText = articleDetail.articleList[sender.tag]
        present(secondVC, animated: true, completion: nil)

        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        addTargets()
        
    }
    
    private func addTargets() {
        print("hi")
        button.addTarget(self, action: #selector(userDidClickOnButton), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .gray
        view.addSubview(text)
        view.addSubview(button)
        text.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class SecondViewController: UIViewController {
    private let detailTitle: UILabel = {
        let ttDetail = UILabel()
        ttDetail.frame = CGRect(x: 70, y: 60, width: 200, height: 30)
    
        ttDetail.text = articleDetail.articleList[button.tag]
        
        return ttDetail
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(detailTitle)
        
    }
    
    @objc
    private func requestToDismiss() {
        dismiss(animated: true, completion: nil)
    }
}



