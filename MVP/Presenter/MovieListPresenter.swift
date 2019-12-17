//
//  MovieListPresenter.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 14-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

protocol MoviesPresenterProtocol: LifeCircleProtocol {
    func attachView(view : ListMovieViewProtocol)
    func deAttachView()
    
    // User interaction
    func retreiveMovies()
    func selectMovie(movie: MovieResume)
    func removeMovie(idMovie: Int)
    func findMovie(keywork: String)
}

protocol LifeCircleProtocol {
    //lifeCycleUI
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

class MovielistPresenter {

    private var pageCurrent : Int

    var provider: ProviderProtocol?
    weak var view: ListMovieViewProtocol?
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.pageCurrent = 1
    }
    
    func fetchPopularMovies(page: Int) {
        provider?.getPopular(page: page, completition: { [weak self] result in
              self?.view?.finishLoading()
              switch result {
              case let .success(movies):
                  self?.pageCurrent = page
                  self?.view?.refreshList(movies: movies.results)
                  break
              case let .error(error):
                  debugPrint(error)
                  break
              default:
                  break
              }
        })
    }
    
    func retreiveMorePages() {
        view?.starLoading()
        let tmpPage = pageCurrent+1
        self.fetchPopularMovies(page: tmpPage)
    }

}

extension MovielistPresenter: MoviesPresenterProtocol {
    func retreiveMovies() {
        view?.starLoading()
        pageCurrent = 1
        self.fetchPopularMovies(page: pageCurrent)
    }

     //MARK: INTERACTION VIEW
    func selectMovie(movie: MovieResume) {
        self.view?.goToDetails(movie: movie)
    }
    
    func removeMovie(idMovie: Int) {
        
    }
    
    func findMovie(keywork: String) {
    
    }
    
    func attachView(view : ListMovieViewProtocol){
        self.view = view
    }
    
    func deAttachView(){
        self.view = nil
    }
    
}

extension MovielistPresenter: LifeCircleProtocol {
    func viewDidLoad() {
        self.retreiveMovies()
    }
    func viewWillAppear() {
        
    }
    func viewWillDisappear() {
        
    }
}
