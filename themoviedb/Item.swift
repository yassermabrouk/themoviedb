//
//  Item.swift
//  Rocket
//
//  Created by Yasser Mabrouk on 2/17/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit

class Item: NSObject {

    private var _itemUrl : String!
    private var _itemTitle : String!
    private var _itemDescription : String!
    
    init(imageUrl : String, imageTitle:String, description:String) {
        _itemUrl = imageUrl
        _itemTitle = imageTitle
        _itemDescription = description
    }
    
    var itemUrl: String{
    return _itemUrl
    }
    
    var itemTitle: String{
        return _itemTitle
    }

    var itemDescription: String{
        return _itemDescription
    }
    
}
