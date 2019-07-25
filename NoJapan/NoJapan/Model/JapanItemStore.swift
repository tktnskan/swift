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
    
    public func updateJapanItems(_ field: String, currentValue: String, updatedValue: String) throws {
        let items = try findItemsByField(field, value: currentValue)
        try! realm!.write {
            items.setValue(updatedValue, forKeyPath: "\(field)")
        }
    }
    
    public func findItemsByField(_ field: String, value: String) throws -> Results<JapanItem> {
        if (realm != nil) {
            let predicate = NSPredicate(format: "%K == %@", field, value)
            return realm!.objects(JapanItem.self).filter(predicate)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func findItemsByTitle(_ title: String) throws -> Results<JapanItem>
    {
        return try findItemsByField("title", value: title)
    }
    
    public func deleteJapanItem(_ japanitem: JapanItem) throw {
        
        if (realm != nil) {
            let predicate = NSPredicate(format: "title == %@ AND description == %@ AND alter == %@", japanitem.title, japanitem.description, japanitem.alter)
            
            let targetItems = realm!.objects(JapanItem.self).filter(predicate)
            
            var items = targetItems.makeIterator()
            while let item = items.next() {
                try! realm!.write {
                    realm!.delete(item)
                }
            }
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func makeNewJapanItem(_ title: String, description: String, alter: String) -> JapanItem
    {
        let newItem = JapanItem()
        newItem.title = title
        newItem.description = description
        newItem.alter = alter
        
        return newItem
    }
}
