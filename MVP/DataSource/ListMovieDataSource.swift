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
    
    private var movies: [MovieResume]
    
    public var moviesCount: Int {
        movies.count
    }
    
    override init () {
        movies = []
    }
    
    func getMovie(id: Int) -> MovieResume?{
        let result = movies.filter{ $0.id == id }
        return result.first
    }
    
    func getMovie(index: IndexPath) -> MovieResume?{
        let result = movies[index.row]
        return result
    }
    
    func append(elements: [MovieResume]) {
        movies.append(contentsOf: elements)
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
