//
//  ViewController.swift
//  test1
//
//  Created by Jinyung Yoon on 18/06/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //라벨 아웃렛 변수
    
    @IBOutlet weak var display: UILabel! //!를 붙여주면 값을 암묵적으로 추출해서 누구든 자유롭게 쓸수 있게 하겠다는 뜻, 만약 nil이면 앱이 멈춘다.
    
    
    
    //스위프트에서는 모든 변수가 초기값을 가져야 한다!
    
    var userIsInTheMiddleOfTyping: Bool = false
    
    
    
    //숫자 눌렀을 때
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        
        
        // 경고가 뜬다.
        
        //let을 넣어야 한다. 읽어오고 싶을 때..array나 dictionary를 사용할 때
        
        //"!" 는 옵셔널 강제적으로 값을 가져올때, 하지만 set 되지 않은 값이 있다면 충돌이 일어난다.
        
        //안전하게 꺼내오는 방법이 있다.
        
        
        
        let digit = sender.currentTitle! //!를 붙여줘서 옵셔널 -> stirng 타입으로 바뀌었다.
        
        
        
        //숫자를 입력중이라면
        
        if(userIsInTheMiddleOfTyping){
            
            //text를 옵셔널 타입에 보낼수 없어서 생기는 에러(옵셔널은 텍스트를 이해할 수 없다.-> ullable 타입인 display의 연관값을 가져와야 한다.)
            
            //display의 값이 nil이라면 에러가 뜬다.
            
            let textCurrentlyInDisplay = display.text!
            
            display.text = textCurrentlyInDisplay + digit
            
        }else{
            
            //입력중이 아니라면(처음 키패드를 눌렀을 때 0이 나오게)
            
            display.text = digit
            
        }
        
        userIsInTheMiddleOfTyping = true
        
        
        
    }
    
    
    
    //파이가 눌러졌을때
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        
        
        //뒤에 느낌표 붙여서 옵셔널을 스트링값으로 바꾸기 (강제추출) , 값이 nil일 때 충돌남
        
        //let mathematicalSymbol = sender.currentTitle!
        
        
        
        //더 안전한 방법(set이 되었을 때)
        
        if let mathematicalSymbol = sender.currentTitle{
            
            //파이를 입력할 때 숫자들 지워버리기
            
            userIsInTheMiddleOfTyping = false
            
            if mathematicalSymbol == "π"{
                
                display.text = String(M_PI)
                
            }
            
            
            
        }
        
        
        
    }
    

}

