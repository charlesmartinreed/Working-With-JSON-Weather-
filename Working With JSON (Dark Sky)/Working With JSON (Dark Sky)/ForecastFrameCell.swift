//
//  ForecastFrameCell.swift
//  Working With JSON (Dark Sky)
//
//  Created by Charles Martin Reed on 1/18/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit

protocol ForecastSearchBarDelegate {
    func didTapSearchButton()
    func retrieveWeatherForLocation(userLocation: String)
}

class ForecastFrameCell : UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: ForecastSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with weather: Weather) {
        iconImageView.image = UIImage(named: weather.icon)
        summaryLabel.text = weather.summary
        highTempLabel.text = "HI:\(Int(weather.highTemperature))"
        lowTempLabel.text = "LO:\(Int(weather.lowTemperature))"
    }
    
}

extension ForecastFrameCell : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didTapSearchButton()
        
        //if neither empty, we can use the search bar string as our location
        if let locationString = searchBar.text, !locationString.isEmpty {
            delegate?.retrieveWeatherForLocation(userLocation: locationString)
        }
    }
}
