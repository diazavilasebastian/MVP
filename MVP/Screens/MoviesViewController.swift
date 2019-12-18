//
//  ViewController.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import UIKit

protocol ListMovieViewProtocol: class {
    //Upddate UI
    func starLoading()
    func finishLoading()
    func refreshList(movies: [MovieResume])
    
    
    /// QUESTION
    /// - Parameter movie: id movie to show in detail
    func goToDetails(movie: MovieResume)
}

class MoviesViewController: UIViewController {
    
    var datasource: ListMovieDataSource?
    var collectionView: UICollectionView
    var presenter: MoviesPresenterProtocol

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.stopAnimating()
        return view
    }()
    
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        datasource = ListMovieDataSource(cellIdentifier: MoviesCollectionViewCell.identifier)
        presenter = MovielistPresenter(provider: MovieProvider())
        super.init(nibName: nil, bundle: nil)
        self.configView()
    }
    

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.retreiveMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    func configView() {
        collectionView.dataSource = self.datasource
        collectionView.delegate = self
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(loadingView)
        self.view.addSubview(self.collectionView)

        NSLayoutConstraint.activate([
            .init(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            .init(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0),
            .init(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: collectionView, attribute: .trailing, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1.0, constant: 0),
        ])
        
        self.collectionView.backgroundColor = .white
    }

    @objc
    func getMovies(){
        presenter.retreiveMovies()
    }
    
}

extension MoviesViewController: ListMovieViewProtocol {
    func goToDetails(movie: MovieResume) {
        let movieDetail = Movie(resume: movie)
        let detailMovie = MovieViewController(model: movieDetail)
        self.navigationController?.show(detailMovie, sender: nil)
    }
    
    func starLoading() {
        self.loadingView.startAnimating()
    }
    
    func finishLoading() {
        self.loadingView.stopAnimating()
    }
    
    func refreshList(movies: [MovieResume]) {
        self.datasource?.movies.append(contentsOf: movies)
        collectionView.reloadData()
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = datasource?.movies[indexPath.row] {
            self.presenter.selectMovie(movie: movie )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (datasource?.movies.count ?? 0) - 5 {
            self.presenter.retreiveMoreMovies()
        }
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: ((collectionView.bounds.size.width/2) - 10), height: 320)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
    }
}
