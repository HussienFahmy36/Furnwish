//
//  ViewController.swift
//  Furnwish
//
//  Created by mac on 1/29/18.
//  Copyright © 2018 Furnwish. All rights reserved.
//

import UIKit

class FurnwishProductsViewer: UIViewController, UITableViewDelegate, UITableViewDataSource, FurnishProductCellDelegate {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var itemsSelectedLabel: UILabel!
    let tableViewDatasource: [FurnwishProduct?] = TempProductsGenerator.generateProductsList()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - tabelview delegate
    ///////////////////////// Tableview delegate /////////////////////////////
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let productCell = tableView.dequeueReusableCell(withIdentifier: FurnwishConstants.FurnwishProductsViewer.productCellIdentifier, for: indexPath) as! FurnwishProductCell
        productCell.showProduct(Product: tableViewDatasource[indexPath.row],delegate: self)
        productCell.makeCellLookAsTheme()
        return productCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDatasource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(FurnwishConstants.FurnwishProductsViewer.productCellHeight)
    }
    
    
    //MARK: - FurnishProductCellDelegate delegate
    ///////////////////////// FurnishProductCellDelegate delegate /////////////////////////////

    func productItemFavouriteStatusChanged(product: FurnwishProduct) {
        if product.isInMyFavourties {
            product.isInMyFavourties = false
            FurnwishSession.shared.removeProductFromFavourite(product: product)
        }
        else {
            product.isInMyFavourties = true
            FurnwishSession.shared.addToProductFavourite(product: product)
        }
        
        updateView()
    }
    
    //MARK: - actions
    ///////////////////////// actions /////////////////////////////
    
    @IBAction func nextClicked(_ sender: Any) {
        let productARViewerViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductARViewerViewController") as! ProductARViewerViewController
        self.navigationController?.show(productARViewerViewController, sender: self)
    }
    
    
    //MARK: - helper methods
    ///////////////////////// helper methods /////////////////////////////

    fileprivate func updateView() {
        itemsSelectedLabel.text = "\(FurnwishSession.shared.getCurrentlyFavouriteProductList().count) items selected"
        productsTableView.reloadData()
    }

    
}

