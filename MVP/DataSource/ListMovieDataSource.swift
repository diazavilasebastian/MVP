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
    
    var movies: [Movie] = []
    
    override init() {
        movies = [
            Movie(id: 1, imdbId: "a", originalLanguage: "a", originalTitle: "A", overview: "A", popularity: 2.6, posterPath: "AWDA", productionCompanies: nil, genres: nil, status: "awd", tagline: "awd", title: "awd", voteAverage: 2.3)
        ]
    }
    
}

extension ListMovieDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell()
        cell.movie = movies[indexPath.row]
        return cell
    }
}
