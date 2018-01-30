//
//  FurnwishProductCollectionViewCell.swift
//  Furnwish
//
//  Created by mac on 1/30/18.
//  Copyright © 2018 Furnwish. All rights reserved.
//

import UIKit

class FurnwishProductCollectionViewCell: UICollectionViewCell, ApplyThemeToCurrentCellDelegate {
    @IBOutlet weak var furniwishProductImage: UIImageView!
    var product: FurnwishProduct!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func showProduct(Product: FurnwishProduct?){
        furniwishProductImage.image = Product?.images?.first!
    }
    func makeCellLookAsTheme() {
        furniwishProductImage.layer.cornerRadius = 4
        furniwishProductImage.clipsToBounds = true
    }
    
}
