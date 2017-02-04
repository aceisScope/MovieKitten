//
//  CatViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 03/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit
import Foundation

class CatViewController: UIViewController {

    private let movieSegue = "showMoviesSegue"
    private let searchKey = "Search"
    private var movieResults:Dictionary<String, AnyObject> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func catTapped(_ sender: Any) {
        APIWrapper.search(title: "star") { (data, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.displayErrorMessage()
                }
                return
            }

            self.movieResults = data as! Dictionary<String, AnyObject>
            guard let _ = self.movieResults[self.searchKey] else { return }

            DispatchQueue.main.sync {
                self.performSegue(withIdentifier: self.movieSegue, sender: self)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == movieSegue else { return }
        let viewController = segue.destination as! MovieViewController
        viewController.movies = self.movieResults[searchKey] as! [Dictionary<String, String>]
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
