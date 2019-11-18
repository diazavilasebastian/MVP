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
        
}

extension ListMovieDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MOVIECELL") as! MoviesTableViewCell
        cell.movie = movies[indexPath.row]
        return cell
    }
}
