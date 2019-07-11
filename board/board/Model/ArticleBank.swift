//
//  ArticleBank.swift
//  board
//
//  Created by Jinyung Yoon on 04/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import Foundation

class ArticleBank {
    var articleList = [Article]()

    init() {
        articleList.append(Article(setTitle: "first trial", inputContent: "Good to see you"))
    }
}
