//
//  ListMovieDataSource.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 14-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation
import UIKit

class ListMovieDataSource: NSObject {
    
    var movies: [MovieResume] = []
    var cellIdentifier : String
    
    init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }
        
}

extension ListMovieDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.movie = movies[indexPath.row]
        return cell
    }
}
