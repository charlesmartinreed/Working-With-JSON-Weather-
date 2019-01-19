//
//  ForecastFrameCell.swift
//  Working With JSON (Dark Sky)
//
//  Created by Charles Martin Reed on 1/18/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit

class ForecastFrameCell : UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
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
