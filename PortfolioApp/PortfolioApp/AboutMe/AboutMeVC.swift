//
//  ViewController.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 05/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class AboutMeVC: UIViewController {
//    var param: AboutMeData?
    @IBOutlet var aboutmeTitle: UILabel!
    @IBOutlet var aboutmeContents: UILabel!
    @IBOutlet var aboutmeImg: UIImageView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        self.aboutmeTitle.text = appDelegate.aboutme.title
//        print("---------------------")
//        print(self.appDelegate.aboutme.contents)
        self.aboutmeContents.text = self.appDelegate.aboutme.contents
        self.aboutmeImg.image = self.appDelegate.aboutme.image
    }
    

}

