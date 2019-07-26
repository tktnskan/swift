//
//  JapanItemStore.swift
//  NoJapan
//
//  Created by Jinyung Yoon on 26/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import Foundation
import RealmSwift

enum RuntimeError: Error {
    case NoRealmSet
}


class JapanItemStore {
    var realm: Realm?
    
    public func saveJapanItems(_ item: JapanItems) throws {
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
    
    public func findItemsByField(_ field: String, value: String) throws -> Results<JapanItems> {
        if (realm != nil) {
            let predicate = NSPredicate(format: "%K == %@", field, value)
            return realm!.objects(JapanItems.self).filter(predicate)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func findItemsByTitle(_ title: String) throws -> Results<JapanItems>
    {
        return try findItemsByField("title", value: title)
    }
    
    public func deleteJapanItem(_ japanitem: JapanItems) throws {
        
        if (realm != nil) {
            let predicate = NSPredicate(format: "title == %@ AND description == %@ AND alter == %@", japanitem.title, japanitem.description, japanitem.alter)
            
            let targetItems = realm!.objects(JapanItems.self).filter(predicate)
            
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
    
    public func makeNewJapanItem(_ title: String, description: String, alter: String) -> JapanItems
    {
        let newItem = JapanItems()
        newItem.title = title
        newItem.descrip = description
        newItem.alter = alter
        
        return newItem
    }
}
