//
//  BeerDB.swift
//  BeerCraft
//
//  Created by ARY@N on 28/07/19.
//

import UIKit
import RealmSwift

class BeerDB: Object {
    
    @objc dynamic var Name: String = ""
    @objc dynamic var ID: Int = 0
    @objc dynamic var Style: String = ""
    @objc dynamic var Abv: String = ""
    @objc dynamic var Ounces: Int = 0
    let parentCategory = LinkingObjects(fromType: Category.self, property: "beer")
}
class Category: Object{
    let beer = List<BeerDB>()
}
