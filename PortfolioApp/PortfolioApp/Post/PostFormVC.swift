//
//  PostFormVC.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 06/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class PostFormVC: UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postContents: UITextView!
    
    
    override func viewDidLoad() {
        self.postContents.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        
        // 내용을 입력하지 않았을 경우, 경고한다.
        guard self.postContents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        // MemoData 객체를 생선하고, 데이터를 담는다.
        let data = PostData()
        
        data.postTitle = self.postTitle.text
        data.postContents = self.postContents.text
        data.postRegdate = Date()
        
        // 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.postlist.append(data)
        
        // 작성폼 화면을 종료하고, 이전 화면으로 돌아간다.
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
