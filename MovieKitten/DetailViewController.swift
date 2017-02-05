//
//  DetailViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 04/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movie = Dictionary<String, String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()

        loadPosterImage()
    }

// MARK: Data

    private let posterKey = "Poster"
    private let titleKey = "Title"
    private let yearKey = "Year"
    private let releaseKey = "Released"
    private let genreKey = "Genre"
    private let directorKey = "Director"
    private let actorKey = "Actors"
    private let plotKey = "Plot"

// MARK: Sub Views

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var poster: UIImageView!

    private let cellIdentifier = "DetailCell"

    func loadPosterImage() {
        guard let posterURL = movie[posterKey] else {
            poster.image = UIImage(named: "placeholder_cat.jpg")
            return
        }

        poster.loadImageFromServerURL(urlString: posterURL)
    }

// MARK: UITableViewDataSource 

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! DetailMovieTableViewCell

        switch indexPath.row {
        case 0:
            cell.titleLabel.text = titleKey
            cell.descriptionLabel.text = "\(movie[titleKey]!) (\(movie[yearKey]!))"
        case 1:
            cell.titleLabel.text = releaseKey
            cell.descriptionLabel.text = movie[releaseKey]!
        case 2:
            cell.titleLabel.text = genreKey
            cell.descriptionLabel.text = movie[genreKey]!
        case 3:
            cell.titleLabel.text = directorKey
            cell.descriptionLabel.text = movie[directorKey]!
        case 4:
            cell.titleLabel.text = actorKey
            cell.descriptionLabel.text = movie[actorKey]!
        case 5:
            cell.titleLabel.text = plotKey
            cell.descriptionLabel.text = movie[plotKey]!
        default:
            break
        }

        return cell
    }

}
