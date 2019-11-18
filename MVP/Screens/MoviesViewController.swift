//
//  ViewController.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import UIKit

protocol ListMovieViewProtocol {
    //Upddate UI
    func starLoading()
    func finishLoading()
    func refreshList(movies: [MovieResume])
}

class MoviesViewController: UIViewController {
    
    var datasource: ListMovieDataSource?
    var tableView: UITableView?
    var refreshControl: UIRefreshControl
    var presenter: MoviesPresenterProtocol

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.stopAnimating()
        return view
    }()
    
    
    init() {
        tableView = UITableView(frame: .zero)
        refreshControl = UIRefreshControl()
        datasource = ListMovieDataSource()

        presenter = MovielistPresenter(provider: MovieProvider())
        super.init(nibName: nil, bundle: nil)
        self.configView()
        
    }
    
    override func loadView() {
         self.view = tableView
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
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    func configView() {
        tableView?.dataSource = self.datasource
        tableView?.register(MoviesTableViewCell.self, forCellReuseIdentifier: "MOVIECELL")
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getMovies), for: .valueChanged)

        self.view.addSubview(loadingView)

        NSLayoutConstraint.activate([
            .init(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            .init(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
        ])
    }

    @objc
    func getMovies(){
        presenter.retreiveMovies()
    }
    
}

extension MoviesViewController: ListMovieViewProtocol {
    func starLoading() {
        self.loadingView.startAnimating()
    }
    
    func finishLoading() {
        self.loadingView.stopAnimating()
    }
    
    func refreshList(movies: [MovieResume]) {
        self.datasource?.movies.append(contentsOf: movies)
        tableView?.reloadData()
    }
}

