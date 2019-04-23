//
//  Item.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 21/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import Foundation

enum Category: String{
    case A = "Category A"
    case B = "Category B"
}

class Item{
    var itemName: String?
    var itemDescription: String?
    var itemCategory: Category?
    var itemCategoyString: String?
    var isFavorite: Bool?
    
    init(itemName: String, itemDescription: String, itemCategory: Category, isFavorite: Bool) {
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemCategory = itemCategory
        self.itemCategoyString = itemCategory.rawValue
        self.isFavorite = isFavorite
    }
}
