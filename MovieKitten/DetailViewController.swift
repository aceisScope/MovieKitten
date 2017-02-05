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
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! DetailMovieTableViewCell

        cell.titleLabel.text = "Title"
        cell.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor felis nisi, sagittis efficitur mi ultricies et. Donec sollicitudin gravida nibh, a dapibus mauris hendrerit ac. Nulla facilisi. Curabitur in pharetra urna, a hendrerit mauris. Maecenas in tristique felis. Duis pellentesque enim nulla, nec pulvinar diam volutpat et. Fusce condimentum nibh eu nibh bibendum tempus. Mauris viverra at nisl vitae condimentum. Integer commodo nisl ipsum, at posuere ex hendrerit id."

        return cell
    }
}
