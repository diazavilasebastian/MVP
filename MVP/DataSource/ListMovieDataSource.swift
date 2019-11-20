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

extension ListMovieDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MoviesTableViewCell
        cell.movie = movies[indexPath.row]
        return cell
    }
}
