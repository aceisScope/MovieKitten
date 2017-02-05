//
//  DetailViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 04/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var movie = Dictionary<String, String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPosterImage()
    }

// MARK: Data

    private let posterKey = "Poster"

// MARK: Sub Views

    @IBOutlet weak var poster: UIImageView!

    func loadPosterImage() {
        guard let posterURL = movie[posterKey] else {
            return
        }

        poster.loadImageFromServerURL(urlString: posterURL)
    }
}
