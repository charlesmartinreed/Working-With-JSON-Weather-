//
//  ViewController.swift
//  Working With JSON (Dark Sky)
//
//  Created by Charles Martin Reed on 1/18/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    //MARK:- Properties
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        title = "JSON Basics?"
        
        Weather.forecast(withLocation: "32.7767,96.7970") { (results: [Weather]) in
            for result in results {
                print("\(result)\n\n")
            }
        }
    }

}

