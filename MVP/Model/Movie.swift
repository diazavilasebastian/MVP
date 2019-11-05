//
//  Movie.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

struct Movie {

    var id: Int
    var imdb_id: String
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity:  Int
    var posterPath: String

    var productionCompanies: [Company]
    var genres: [Genre]

    var status: String
    var tagline: String
    var title: String
    var voteAverage: Int
    
}
