//
//  PageCell.swift
//  NoJapan
//
//  Created by Jinyung Yoon on 25/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import RealmSwift

class JapanItem: Object {
    @objc dynamic var title = ""
    @objc dynamic var description = ""
    @objc dynamic var alter = ""
}
