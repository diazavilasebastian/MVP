//
//  MovieProvider.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 14-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

protocol ProviderProtocol {

    typealias listMoviesResult = (Result<PageMovies,ErrorService>) -> Void
    typealias movieResult = (Result<Movie,ErrorService>) -> Void

    func getMovie(id: Int, completition: @escaping movieResult )
    func getTopRated(completition: @escaping listMoviesResult)
    func getUpcoming(completition: @escaping listMoviesResult)
    func getPopular(completition: @escaping listMoviesResult)
}


class MovieProvider: ProviderProtocol {
    
    var service: ServiceProtocol
    
    
    init(service: ServiceProtocol = ApiService()) {
        self.service = service
    }
    
    func getMovie(id: Int, completition: @escaping movieResult) {
        service.getMovie(id: id) { completition($0) }
    }
    
    func getTopRated(completition: @escaping listMoviesResult) {
        service.getTopRated { completition($0) }
    }
    
    func getUpcoming(completition: @escaping listMoviesResult) {
        service.getUpcoming { completition($0) }
    }
    
    func getPopular(completition: @escaping listMoviesResult) {
        service.getPopular { completition($0) }
    }
    
}
