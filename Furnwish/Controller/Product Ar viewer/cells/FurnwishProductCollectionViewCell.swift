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
    @IBOutlet weak var currentlySelectedProductImage: UIImageView!
    var isProductSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func showProduct(Product: FurnwishProduct?){
        furniwishProductImage.image = Product?.images?.first!
        if isProductSelected {
            currentlySelectedProductImage.image = UIImage.init(named: "checkbox-icon")
        }
        else{
            currentlySelectedProductImage.image = nil
        }
    }
    func makeCellLookAsTheme() {
        furniwishProductImage.layer.cornerRadius = 4
        furniwishProductImage.clipsToBounds = true
    }
    
}
