//
//  FurnwishProduct.swift
//  Furnwish
//
//  Created by mac on 1/30/18.
//  Copyright © 2018 Furnwish. All rights reserved.
//

import UIKit

class FurnwishProduct: NSObject {
    var number: Int!
    var isInMyFavourties: Bool = false
    var name: String!
    var price: Float = 0
    var images: [UIImage]?
    var modelFile: String!
    
    init(number: Int, name: String, price: Float, images: [UIImage]?, modelFile: String) {
        self.number = number
        self.name = name
        self.price = price
        self.images = images
        self.modelFile = modelFile
    }
    convenience init(number: Int, name: String, price: Float, images: [UIImage]?, modelFile: String, isInMyFavourites: Bool) {
        self.init(number: number, name: name, price: price, images: images, modelFile: modelFile)
        self.isInMyFavourties = isInMyFavourites
        
    }
    override init() {
        super.init()
    }
    
    
}
