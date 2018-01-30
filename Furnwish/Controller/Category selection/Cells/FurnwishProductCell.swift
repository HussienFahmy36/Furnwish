//
//  FurnitureProductCell.swift
//  Furnwish
//
//  Created by mac on 1/30/18.
//  Copyright © 2018 Furnwish. All rights reserved.
//

import UIKit

class FurnwishProductCell: UITableViewCell, ApplyThemeToCurrentCellDelegate {

    @IBOutlet weak var sliderImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var addToFavouriteButton: UIImageView!
    var delegate: FurnishProductCellDelegate!
    var product: FurnwishProduct!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func showProduct(Product: FurnwishProduct?, delegate: FurnishProductCellDelegate){
        if Product != nil {
            self.product = Product!
            sliderImage.image = Product?.images?.first!
            title.text = Product?.name
            price.text = "\(Product!.price) EGP"
            self.selectionStyle = .none
            self.delegate = delegate
            drawFavouriteButton()
        }
        
        
    }
    fileprivate func drawFavouriteButton(){
        if product.isInMyFavourties {
            addToFavouriteButton.image = UIImage.init(named: FurnwishConstants.FurnwishProductsViewer.favouriteRemoveButtonIcon)
        }
        else{
            addToFavouriteButton.image = UIImage.init(named: FurnwishConstants.FurnwishProductsViewer.favouriteAddButtonIcon)

        }
    }
    func makeCellLookAsTheme(){
        sliderImage.layer.cornerRadius = 2
        sliderImage.mask?.clipsToBounds = true
        sliderImage.layer.shadowColor = UIColor.black.cgColor
        sliderImage.layer.shadowOpacity = 1
        sliderImage.layer.shadowOffset = CGSize.zero
        sliderImage.layer.shadowRadius = 2
    }
    @IBAction func addToFavouriteButtonAction(_ sender: Any) {
        delegate.productItemFavouriteStatusChanged(product: product)
    }
    
    
}
