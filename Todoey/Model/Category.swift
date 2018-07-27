//
//  Category.swift
//  Todoey
//
//  Created by Travis Yatsko on 7/20/18.
//  Copyright © 2018 Travis Yatsko. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name: String = ""
    let items = List<Item>() 
}
