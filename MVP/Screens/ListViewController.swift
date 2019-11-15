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
    func refreshList(movies: [Movie])
}

class ListViewController: UIViewController {
    
    var datasource: ListMovieDataSource?
    var tableView: UITableView?
    var presenter: MovieListPresenterProtocol

    init() {
        tableView = UITableView(frame: .zero)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        datasource = ListMovieDataSource()
        presenter = MovielistPresenter(provider: MovieProvider())
        super.init(nibName: nil, bundle: nil)
        
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
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
}

extension ListViewController: ListMovieViewProtocol {
    func starLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func refreshList(movies: [Movie]) {
        self.datasource?.movies = movies
        tableView?.reloadData()
    }
}

