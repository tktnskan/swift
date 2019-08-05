//
//  AboutMeEditVC.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 05/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class AboutMeEditVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    
    override func viewDidLoad() {
        self.contents.delegate = self
    }
    
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않았을 경우, 경고한다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        self.appDelegate.aboutme.contents = self.contents.text
        self.appDelegate.aboutme.image = self.preview.image
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func pickImg(_ sender: Any) {
        
        let select = UIAlertController(title: "이미지를 선택해주세요", message: nil, preferredStyle: .actionSheet)
        
        select.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in self.selectedPhoto(source: .camera)})
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
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
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
