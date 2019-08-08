//
//  ViewController.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 06/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController, UIScrollViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var aboutmeContents: UILabel!
    @IBOutlet weak var aboutmeImg: UIImageView!

    //    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        aboutmeContents.text = appDelegate.aboutme.contents
//        print(appDelegate.aboutme.contents)
//        print(aboutmeContents.text)
//        aboutmeImg.image = appDelegate.aboutme.image
//
//    }

    override func viewWillAppear(_ animated: Bool) {
        aboutmeContents.text = appDelegate.aboutme.aboutmeContents
        aboutmeImg.image = appDelegate.aboutme.aboutmeImage
    }


}

