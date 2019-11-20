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
    var tableView: UITableView
    var presenter: MoviesPresenterProtocol
    
    let cellIdentifier : String = "MOVIECELL"

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.stopAnimating()
        return view
    }()
    
    
    init() {
        tableView = UITableView(frame: .zero)
        datasource = ListMovieDataSource(cellIdentifier: cellIdentifier)
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
        tableView.dataSource = self.datasource
        tableView.delegate = self
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(loadingView)
        self.view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            .init(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            .init(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0),
            .init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: tableView, attribute: .trailing, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1.0, constant: 0),
        ])
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
        tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = datasource?.movies[indexPath.row] {
            self.presenter.selectMovie(movie: movie )
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

