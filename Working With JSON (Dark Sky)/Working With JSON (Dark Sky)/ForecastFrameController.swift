//
//  ForecastFrame.swift
//  Working With JSON (Dark Sky)
//
//  Created by Charles Martin Reed on 1/18/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastFrameController : UICollectionViewController {
    
    //MARK:- Properties
    let cellIdentifier = "ForecastCell"
    var forecasts = [Weather]()
    
//    lazy var pageControl: UIPageControl = {
//        let pc = UIPageControl()
//        pc.currentPage = 0
//        pc.numberOfPages = forecasts.count
//        pc.currentPageIndicatorTintColor = .black
//        pc.pageIndicatorTintColor = .lightGray
//
//        return pc
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- collectionView setup
        collectionView.dataSource = self
        collectionView.delegate = self
        
        updateWeatherForLocation(location: "Dallas")
        
        //collectionView.backgroundColor = .white
        collectionView.register(UINib.init(nibName: "ForecastFrame", bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isPagingEnabled = true //using the bounds of a cell, we denote where the app's layout should "snap" to.
    }
    
    func updateWeatherForLocation(location: String) {
        //we'll have to attempt to geocode the passed string
        CLGeocoder().geocodeAddressString(location) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil {
                //everything was OK! Try to get the location as a set of coords
                if let location = placemarks?.first?.location {
                    //if we got the location, call Weather's forecasting method
                    Weather.forecast(withLocation: location, completion: { (results: [Weather]?) in
                        if let weatherData = results {
                            self.forecasts = weatherData
                            
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }

    //MARK:- collectionView delegate methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let weatherObject = forecasts[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ForecastFrameCell
        cell.configure(with: weatherObject, atIndex: indexPath.item, totalIndices: forecasts.count)
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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


