//
//  CellMaker.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 05/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class CellMaker {
    
    let images = ["bn.jpeg", "bn.jpeg", "bn.jpeg", "bn.jpeg", "bn.jpeg"]
    let descrip = ["포트폴리오", "포트폴리오", "포트폴리오", "포트폴리오", "포트폴리오"]
    
    func collectionView() -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! PortfolioCell
        print(descrip[indexPath.row])
        print(images[indexPath.row])
        cell.image.image = UIImage(named: images[indexPath.row])
        cell.descrips.text = descrip[indexPath.row]
        
        return cell
    }
}
