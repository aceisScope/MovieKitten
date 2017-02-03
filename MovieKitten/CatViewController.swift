//
//  CatViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 03/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func catTapped(_ sender: Any) {
        performSegue(withIdentifier: "showMoviesSegue", sender: self)
    }
}
