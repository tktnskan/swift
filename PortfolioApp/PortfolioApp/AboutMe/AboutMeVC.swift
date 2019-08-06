//
//  ViewController.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 05/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class AboutMeVC: UITableViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    // 포트폴리오 collectionView 구현
    let cellMaker = CellMaker()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellMaker.collectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellMaker.collectionView(collectionView, cellForItemAt: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId") as? AboutmeCell
        
        cell?.aboutmeTitle.text = "About Me"
        cell?.aboutmeContents.text = self.appDelegate.aboutme.contents
        cell?.aboutmeImg.image = self.appDelegate.aboutme.image
        
        return cell!
    }
    
    
    
    // Aboutme  부분
//    var param: AboutMeData?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        // Do any additional setup after loading the view.
//        portfolioTitle.text = "Portfolio"
//        self.aboutmeTitle.text = appDelegate.aboutme.title
////        print("---------------------")
////        print(self.appDelegate.aboutme.contents)
//        self.aboutmeContents.text = self.appDelegate.aboutme.contents
//        self.aboutmeImg.image = self.appDelegate.aboutme.image
//    }
//

}

