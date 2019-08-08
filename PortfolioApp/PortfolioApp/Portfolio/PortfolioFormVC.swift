//
//  PortfolioFormVC.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 07/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class PortfolioFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var portfolioImg: UIImageView!
    
    @IBOutlet weak var portfolioTitle: UITextField!
    @IBOutlet weak var portfolioContents: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePort(_ sender: Any) {
        guard self.portfolioContents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        let portData = PortfolioData()
        
        portData.portfolioTitle = self.portfolioTitle.text
        portData.portfolioContents = self.portfolioContents.text
        portData.portfolioImage = self.portfolioImg.image
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.portfoliolist.append(portData)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func pickImg(_ sender: Any) {
        let select = UIAlertController(title: "이미지를 선택해주세요", message: nil, preferredStyle: .actionSheet)
        
        select.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) { (_) in self.selectedPhoto(source: .photoLibrary)})
        select.addAction(UIAlertAction(title: "저장 앨범", style: .default) { (_) in self.selectedPhoto(source: .savedPhotosAlbum)})
        
        
        self.present(select, animated: false)
    }
    
    
    
    func selectedPhoto(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) == true else {
            let alert = UIAlertController(title: "이미지 타입 오류", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true)
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        
        self.present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 선택된 이미지를 미리보기에 표시한다
        self.portfolioImg.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.portfolioImg.layer.zPosition = 2
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
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
