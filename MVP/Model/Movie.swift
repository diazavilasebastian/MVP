//
//  Movie.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

struct Movie: Codable {

    var id: Int
    var imdbId: String
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String

    var productionCompanies: [Company]
    var genres: [Genre]

    var status: String
    var tagline: String
    var title: String
    var voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"

        case productionCompanies = "production_companies"
        case genres = "genres"

        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case voteAverage = "vote_average"
    }
    
}
