//
//  Constants.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 21/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import Foundation

class Constants{
    static let sharedInstance = Constants()
    var favoritesArray = Array<Item>()
    var itemArray = Array<Item>()
    var username = "JohnDoe"
    var email = "john@doe.com"
    var doj = "01/01/2019"
    var hobby = "blogging"
    private init(){
        
    }
}
