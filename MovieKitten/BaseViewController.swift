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

    func displayActivityIndicator() {
        let alert = UIAlertController(title: nil, message: "Kitten is working...", preferredStyle: .alert)

        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    func removeActivityIndcator(completion: @escaping (() -> Void)) {
        dismiss(animated: false, completion: completion)
    }
}
