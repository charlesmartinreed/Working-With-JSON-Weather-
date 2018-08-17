//
//  ViewController.swift
//  JSON
//
//  Created by Charles Martin Reed on 8/17/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Weather.forecast(withLocation: "37.8267,-122.4233") { (results: [Weather]) in
            for result in results {
                print("\(result)\n\n")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

