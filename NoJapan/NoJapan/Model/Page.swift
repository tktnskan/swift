//
//  Page.swift
//  NoJapan
//
//  Created by Jinyung Yoon on 25/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import Foundation
import RealmSwift

enum RuntimeError: Error {
    case NoRealmSet
}


class JapanItemStore {
    var realm: Realm?
    
    public func saveJapanItems(_ item: JapanItem) throws {
        if (realm != nil) {
            try! realm!.write {
                realm!.add(item)
            }
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func updateJapanItems(_ i)
}
