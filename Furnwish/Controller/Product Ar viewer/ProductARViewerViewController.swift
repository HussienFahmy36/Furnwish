//
//  ProductARViewerViewController.swift
//  Furnwish
//
//  Created by mac on 1/30/18.
//  Copyright © 2018 Furnwish. All rights reserved.
//

import UIKit
import ARKit

class ProductARViewerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var ARsceneKit: ARSCNView!
    let datasource: [FurnwishProduct] = FurnwishSession.shared.getCurrentlyFavouriteProductList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBox()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        let configuration = ARWorldTrackingConfiguration()
        ARsceneKit.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ARsceneKit.session.pause()
    }
    

    //MARK: - collectionview delegate
    ///////////////////////// collectionview delegate /////////////////////////////
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: FurnwishConstants.ProductARViewerViewController.productCellIdentifier, for: indexPath) as! FurnwishProductCollectionViewCell
        productCell.showProduct(Product: datasource[indexPath.row])
        productCell.makeCellLookAsTheme()
        return productCell

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
     
    //MARK: - actions
    ///////////////////////// actions /////////////////////////////
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - for testing purpose
    //////////////// for testing purpose
    func addBox() {
        let box = SCNBox(width: 0.4, height: 0.2, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(0, 0, -0.6)
        
        let scene = SCNScene()
        scene.rootNode.addChildNode(boxNode)
        ARsceneKit.scene = scene
    }
    
}
