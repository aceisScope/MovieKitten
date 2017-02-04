//
//  MovieCollectionViewCell.swift
//  MovieKitten
//
//  Created by Binghui Liu on 04/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    var movie = Dictionary<String, String>() {
        didSet {
            guard let imageURL = movie[posterKey] else { return }
            moviePoster.loadImageFromServerURL(urlString: imageURL)
        }
    }

    private let posterKey = "Poster"
    
    @IBOutlet weak var moviePoster: UIImageView!

    override func awakeFromNib() {

    }
}

/// http://stackoverflow.com/questions/37018916/swift-async-load-image this piece of code is a quick implementation from SO.
/// If given a more complex application case, framework such as Alamofire (https://github.com/Alamofire/AlamofireImage)
/// and PINRemoteImage (https://github.com/pinterest/PINRemoteImage) should be used.
extension UIImageView {
    public func loadImageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            guard error == nil else { return }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
