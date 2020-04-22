//
//  Router.swift
//  MVP
//
//  Created by ITAU on 12-02-20.
//  Copyright © 2020 ITAU. All rights reserved.
//

import Foundation
import UIKit

protocol RouterMovieProtocol {
    func goToDetailsMovie(movie: MovieResume)
}

class Router {

    var navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

}

extension Router: RouterMovieProtocol {

    func goToDetailsMovie(movie: MovieResume) {
        let movieDetail = Movie(resume: movie)
        let detailMovie = MovieViewController(model: movieDetail)
        navigation.show(detailMovie, sender: nil)
    }
}
