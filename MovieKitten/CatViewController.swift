//
//  CatViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 03/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit
import Foundation

class CatViewController: BaseViewController {

    private let movieSegue = "showMoviesSegue"
    private let searchKey = "Search"
    private var movieResults:Dictionary<String, AnyObject> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func catTapped(_ sender: Any) {
        displayActivityIndicator()

        APIWrapper.search(title: "cat") { (data, error) in
            guard error == nil else {
                DispatchQueue.main.sync {
                    self.removeActivityIndcator(completion: {
                        self.displayErrorMessage()
                    })
                }
                return
            }

            self.movieResults = data as! Dictionary<String, AnyObject>
            guard let _ = self.movieResults[self.searchKey] else { return }

            DispatchQueue.main.sync {
                self.removeActivityIndcator(completion: {
                    self.performSegue(withIdentifier: self.movieSegue, sender: self)
                })
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == movieSegue else { return }
        let viewController = segue.destination as! MovieViewController
        viewController.movies = self.movieResults[searchKey] as! [Dictionary<String, String>]
    }
}
