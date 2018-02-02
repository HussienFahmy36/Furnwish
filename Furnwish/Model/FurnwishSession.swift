//
//  FurnwishSession.swift
//  Furnwish
//
//  Created by mac on 1/30/18.
//  Copyright © 2018 Furnwish. All rights reserved.
//

import UIKit

class FurnwishSession: NSObject {
    private var itemsInFavourite: [FurnwishProduct]!
    static let shared: FurnwishSession = FurnwishSession()
    private override init() {
        itemsInFavourite = [FurnwishProduct]()
    }
    
    public func addToProductFavourite(product: FurnwishProduct){
            itemsInFavourite.append(product)
    }
    public func removeProductFromFavourite(product: FurnwishProduct){
        var i = 0
        for item in itemsInFavourite {
            if item.number == product.number
            {
                itemsInFavourite.remove(at: i)
            }
            i = i + 1
        }
    }
    public func getCurrentlyFavouriteProductList() -> [FurnwishProduct]{
        return itemsInFavourite
    }
    
    
}
