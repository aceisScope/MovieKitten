//
//  MovieViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 2017/1/31.
//  Copyright © 2017年 Binghui Liu. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching, UIScrollViewDelegate {

    var searchKeyword = ""
    var movies = [Dictionary<String, String>]()
    private var movieDetail = Dictionary<String, String>()
    
    @IBOutlet weak var collectionView: UICollectionView!

    private let cellIdentifier = "MovieCell"
    private let detailSegue = "showDetailSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = searchKeyword

        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

// MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.movie = movies[indexPath.item]

        return cell
    }


// MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        return squareCellSizeToFill(containerWidth: collectionView.bounds.width, minimumCellWidth: 133, minimumCellsPerRow: 2, edgeMargin: layout.sectionInset.left, spacing: layout.minimumLineSpacing)
    }

// MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        guard let imdb = movie[imdbKey] else {
            displayErrorMessage()
            return
        }

        displayActivityIndicator()

        APIWrapper.detail(imdbID: imdb) { (data, error) in
            guard error == nil else {
                DispatchQueue.main.sync {
                    self.removeActivityIndcator(completion: {
                        self.displayErrorMessage()
                    })
                }
                return
            }

            self.movieDetail = data as! Dictionary<String, String>
            DispatchQueue.main.sync {
                self.removeActivityIndcator(completion: {
                    self.performSegue(withIdentifier: self.detailSegue, sender: self)
                })
            }
        }
    }

// MARK: Helper

    func squareCellSizeToFill(containerWidth: CGFloat, minimumCellWidth: CGFloat, minimumCellsPerRow: Int, edgeMargin: CGFloat = 0, spacing: CGFloat = 0, roundToInteger: Bool = true) -> CGSize {
        var width = containerWidth - edgeMargin * 2

        let minimumWidth = Int(minimumCellWidth + spacing / 2)
        var cellsPerRow = Int(width / CGFloat(minimumWidth))
        cellsPerRow = max(cellsPerRow, minimumCellsPerRow)

        width -= spacing * CGFloat(cellsPerRow - 1)
        width /= CGFloat(cellsPerRow)
        let scaleFactor: CGFloat = roundToInteger ? 1 : UIScreen.main.scale

        let sizeWidth = floor(width * scaleFactor) / scaleFactor

        return CGSize(width: sizeWidth, height: sizeWidth * 1.5)
    }

// MARK: Prefetch

    /// Unfortunately the paging doesn't work properly on OMDB.
    /// Temporary solution is to check if it returns any error, then we assume there's no more pages.
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let lastItem = IndexPath(item: movies.count - 1, section: 0)
        if indexPaths.contains(lastItem) {
            if !isSearching && canSearchMore {
                isSearching = true
                currentPage += 1
                APIWrapper.search(title: searchKeyword, page: currentPage, completion: { (data, error) in
                    self.isSearching = false

                    guard error == nil else {
                        self.canSearchMore = false
                        return
                    }
                    guard let more = (data as! Dictionary<String, AnyObject>)[self.searchKey] else { return }
                    self.movies.append(contentsOf: (more as! [Dictionary<String, String>]))

                    DispatchQueue.main.sync {
                        self.collectionView.reloadData()
                    }
                })
            }
        }
    }


// MARK: Data

    private var currentPage:Int = 1
    private var isSearching = false
    private var canSearchMore = true

    private let searchKey = "Search"
    private let imdbKey = "imdbID"

// MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == detailSegue else { return }
        let viewController = segue.destination as! DetailViewController
        viewController.movie = movieDetail
    }

// MARK: Rotate

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

