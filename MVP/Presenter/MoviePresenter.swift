//
//  MoviePresenter.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 25-01-20.
//  Copyright © 2020 ITAU. All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol {
    
    var view: MovieViewProtocol? { get set }
    var provider: ProviderProtocol? { get }
    
    func attachView(view : MovieViewProtocol)
    func deAttachView()
    
    func retreiveMovieDetail(id: Int)
}

class MoviePresenter {
    
    var view: MovieViewProtocol?
    var provider: ProviderProtocol?
    
    init(provider: ProviderProtocol = MovieProvider()) {
        self.provider = provider
    }

}

extension MoviePresenter: MoviePresenterProtocol {
   
    func attachView(view: MovieViewProtocol) {
        self.view = view
    }
    
    func deAttachView() {
        self.view = nil
    }
    
    func retreiveMovieDetail(id: Int) {
        view?.showLoading()
        provider?.getMovie(id: id, completition: {[weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.view?.hideLoading()
            switch result {
            case let .success(movie):
                strongSelf.view?.showMovieDetail(movie)
            case let .error(error):
                debugPrint(error)
            default:
                break
            }
        })
        
    }
    
}
