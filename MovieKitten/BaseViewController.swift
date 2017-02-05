//
//  BaseViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 05/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func displayErrorMessage() {
        let alertController = UIAlertController(title: "Oops!", message: "It seems OMDB doesn't know what you're looking for", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        let OKAction = UIAlertAction(title: "Try another one", style: .default)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }

}
