//
//  MovieListPresenter.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 14-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

protocol MoviesPresenterProtocol {
    func attachView(view : ListMovieViewProtocol)
    func deAttachView()
    
    // User interaction
    func retreiveMovies()
    func selectMovie(idMovie: Int)
    func removeMovie(idMovie: Int)
    func findMovie(keywork: String)
    
    //lifeCycleUI
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

class MovielistPresenter {

    private var pageCurrent : Int

    var provider: ProviderProtocol?
    var view: ListMovieViewProtocol?
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.pageCurrent = 1
    }

}

extension MovielistPresenter: MoviesPresenterProtocol {
    func retreiveMovies() {
        view?.starLoading()
        let tmpPage = pageCurrent+1
        provider?.getPopular(page: tmpPage, completition: { [weak self] result in
            self?.view?.finishLoading()
            switch result {
            case let .success(page):
                self?.pageCurrent = tmpPage
                self?.view?.refreshList(movies: page.results)
                break
            case let .error(error):
                debugPrint(error)
                break
            default:
                break
            }
        })
    }

    
     //MARK: INTERACTION VIEW
    func selectMovie(idMovie: Int) {
        
    }
    
    func removeMovie(idMovie: Int) {
        
    }
    
    func findMovie(keywork: String) {
    
    }
    
    //MARK: LIFE CYCLE VIEW
    func viewDidLoad() {
        self.retreiveMovies()
    }
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
    
    }
    
    func attachView(view : ListMovieViewProtocol){
        self.view = view
    }
    
    func deAttachView(){
        self.view = nil
    }
    
}
