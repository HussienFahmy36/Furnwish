//
//  TempProductsGenerator.swift
//  Furnwish
//
//  Created by mac on 1/30/18.
//  Copyright © 2018 Furnwish. All rights reserved.
//

import UIKit

class TempProductsGenerator: NSObject {

    static func generateProductsList() -> [FurnwishProduct?]{
        return [FurnwishProduct(number: 1, name: "Golden lamp - chandelier", price: 100, images: [UIImage.init(named: "Golden lamp - chandelier")!], modelFile: ""),FurnwishProduct(number: 1, name: "Wormhole Table model", price: 50, images: [UIImage.init(named: "Wormhole Table model")!], modelFile: "")]
    }
}
