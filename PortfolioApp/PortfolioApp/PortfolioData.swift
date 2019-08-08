//
//  PortfolioData.swift
//  PortfolioApp
//
//  Created by Jinyung Yoon on 06/08/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class AboutMeData {
    var aboutmeContents: String? = "자기소개란 입니다."
    var aboutmeImage: UIImage? = UIImage(named: "bn.jpeg")
}


class PostData {
    var postIdx: Int?
    var postTitle: String?
    var postContents: String?
    var postRegdate: Date?
    var postBanner: String?
}


class PortfolioData {
    var portfolioIdx: Int?
    var portfolioTitle: String?
    var portfolioContents: String?
    var portfolioImage: UIImage?
    var portfolioRegdate: Date?
}
