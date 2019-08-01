//
//  MemoFormVC.swift
//  Memo
//
//  Created by Jinyung Yoon on 30/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var subject: String!
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    
    override func viewDidLoad() {
        self.contents.delegate = self
    }
    
    
    // 저장 버튼을 눌렀을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        
        // 내용을 입력하지 않았을 경우, 경고한다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        // MemoData 객체를 생선하고, 데이터를 담는다.
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        // 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        // 작성폼 화면을 종료하고, 이전 화면으로 돌아간다.
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pickPhoto(_ sender: Any) {
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
    
    func textViewDidChange(_ textView: UITextView) {
        
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        //내비게이션 타이틀에 표시한다.
        self.navigationItem.title = subject
        
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
