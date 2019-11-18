//
//  PageMovies.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 17-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

class PageMovies: Codable {
    var page: Int
    var results: [MovieResume]
}
