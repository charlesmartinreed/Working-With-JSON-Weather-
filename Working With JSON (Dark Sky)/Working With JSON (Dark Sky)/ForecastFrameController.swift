//
//  ForecastFrame.swift
//  Working With JSON (Dark Sky)
//
//  Created by Charles Martin Reed on 1/18/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit

class ForecastFrameController : UICollectionViewController {
    
    //MARK:- Properties
    let cellIdentifier = "ForecastCell"
    var colors: [UIColor] = [.red, .orange, .blue, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //MARK:- collectionView setup
        collectionView.backgroundColor = .white
        collectionView.register(UINib.init(nibName: "ForecastFrame", bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isPagingEnabled = true //using the bounds of a cell, we denote where the app's layout should "snap" to.
    }
    
    //MARK:- collectionView delegate methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ForecastFrameCell
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
    //fix for the spacing issue that occurs between individual cells/sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK:- flow layout delegate methods
extension ForecastFrameController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
