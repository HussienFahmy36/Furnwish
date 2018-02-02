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
    var selectedProduct: FurnwishProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPinchGestureToSceneView()
        addTapGestureToSceneView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
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
        if selectedProduct?.number == datasource[indexPath.row].number {
            productCell.isProductSelected = true
        }

        else{
            productCell.isProductSelected = false
        }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = datasource[indexPath.row]
        collectionView.reloadData()
        
    }
    //MARK: - actions
    func addPinchGestureToSceneView() {
        let pinchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didPinch(withGestureRecognizer:)))
        
        ARsceneKit.addGestureRecognizer(pinchGestureRecognizer)
    }
    func addTapGestureToSceneView(){

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(withGestureRecognizer:)))
        
        ARsceneKit.addGestureRecognizer(tapGestureRecognizer)

    }
    
    ///////////////////////// actions /////////////////////////////
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func didTap(withGestureRecognizer recognizer: UITapGestureRecognizer) {
        if selectedProduct != nil {
            addProduct()
        }
    }

    @objc func didPinch(withGestureRecognizer recognizer: UIPinchGestureRecognizer) {
        
//        let scene = ARsceneKit.scene
//        let node = scene.rootNode.childNode(withName: "Chair", recursively: true)!
//        let action = SCNAction.scale(by: recognizer.scale, duration: 1.0)
//        node.runAction(action)
    }
    
    //MARK: - for testing purpose
    //////////////// for testing purpose
    
    func addBox() {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        let cc = getCameraCoordinates(sceneView: ARsceneKit)
        boxNode.position = SCNVector3(cc.x,cc.x,cc.z)
        ARsceneKit.scene.rootNode.addChildNode(boxNode)
        
    }
    
    func addProduct(){
        let mugNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: ARsceneKit)
        mugNode.position = SCNVector3(cc.x,cc.x,cc.z)
        
        guard let virtualObjectScener = SCNScene(named: (selectedProduct?.modelFile)!) else {
            return
        }
        let wrapperNode = SCNNode()
        for child in virtualObjectScener.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        mugNode.addChildNode(wrapperNode)
        ARsceneKit.scene.rootNode.addChildNode(mugNode)
    }
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        return cc
    }

    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
}

