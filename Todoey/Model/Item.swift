//
//  Item.swift
//  Todoey
//
//  Created by Travis Yatsko on 7/20/18.
//  Copyright © 2018 Travis Yatsko. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
