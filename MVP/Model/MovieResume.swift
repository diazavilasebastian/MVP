//
//  MovieResume.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 17-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

struct MovieResume: Codable {
    
    var adult: Bool
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var id: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var voteAverage: Double
    var posterPath: String

    var urlPoster: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500"+posterPath)!
    }
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id =  "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
