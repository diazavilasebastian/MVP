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
    var originalTitle: String
    var overview: String
    var originalLanguage: String
    var title: String
    var popularity: Double
    var voteAverage: Double
    var posterPath: String
    
    var imdbId: String?
    var productionCompanies: [Company]? = []
    var genres: [Genre]? = []
    var status: String?
    var tagline: String?
        
    var urlPoster: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500"+posterPath)!
    }
    

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
    
    
    init (resume: MovieResume) {
        self.id = resume.id
        self.originalTitle = resume.originalTitle
        self.overview = resume.overview
        self.originalLanguage = resume.originalLanguage
        self.title = resume.title
        self.popularity = resume.popularity
        self.voteAverage = resume.voteAverage
        self.posterPath = resume.posterPath
    }
    
}
