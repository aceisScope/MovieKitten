//
//  MovieViewController.swift
//  MovieKitten
//
//  Created by Binghui Liu on 2017/1/31.
//  Copyright © 2017年 Binghui Liu. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    private let cellIdentifier = "MovieCell"

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        cell.backgroundColor = .red
        return cell
    }


// MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        return squareCellSizeToFill(containerWidth: collectionView.bounds.width, minimumCellWidth: 133, minimumCellsPerRow: 2, edgeMargin: layout.sectionInset.left, spacing: layout.minimumLineSpacing)
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

// MARK: Scroll

    private func isNearBottomOfScroll(within margin: CGFloat) -> Bool {
        guard let view = collectionView, view.contentSize.height > 0 else {
            return true
        }
        return (view.contentOffset.y + view.contentInset.top) < (margin + 1)
    }

    private func isNearTopOfScroll(within margin: CGFloat) -> Bool {
        guard let view = collectionView, view.contentSize.height > 0 else {
            return true
        }
        return (view.contentOffset.y + view.bounds.size.height + 1) > (view.contentInset.bottom + view.contentSize.height - margin)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isNearBottomOfScroll(within: 1) {
            
        }
    }

// MARK: Rotate

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

