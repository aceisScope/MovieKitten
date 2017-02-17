//
//  MovieCollectionViewCell.swift
//  MovieKitten
//
//  Created by Binghui Liu on 04/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    let imageLoader = ImageLoader.shared

    var urlString = ""

    var movie = Dictionary<String, String>() {
        didSet {
            guard let title = movie[titleKey] else { return }
            titleLabel.text = title

            guard let imageURL = movie[posterKey] else { return }
            urlString = imageURL

            moviePoster.image = nil
            imageLoader.loadImageFromServerURL(urlString: imageURL) { (image, urlString) in
                if self.urlString == imageURL {
                    self.moviePoster.image = image
                }
            }
        }
    }

    private let posterKey = "Poster"
    private let titleKey = "Title"
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {

    }
}

