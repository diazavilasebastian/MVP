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
    func selectMovie(idMovie: Int)
    func removeMovie(idMovie: Int)
    func findMovie(keywork: String)
    
    //lifeCycleUI
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

class MovielistPresenter {
    
    var provider: ProviderProtocol?
    var view: ListMovieViewProtocol?
    
    init(provider: ProviderProtocol) {
        self.provider = provider
    }

}

extension MovielistPresenter: MoviesPresenterProtocol {
    
     //MARK: INTERACTION VIEW
    func selectMovie(idMovie: Int) {
        
    }
    
    func removeMovie(idMovie: Int) {
        
    }
    
    func findMovie(keywork: String) {
    
    }
    
    //MARK: LIFE CYCLE VIEW
    func viewDidLoad() {
        view?.starLoading()
        provider?.getPopular { [weak self] result in
            self?.view?.finishLoading()
            switch result {
            case let .success(page):
                self?.view?.refreshList(movies: page.results)
                break
            case let .error(error):
                debugPrint(error)
                break
            default:
                break
            }
        }
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
