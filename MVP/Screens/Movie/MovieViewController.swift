//
//  MovieViewController.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 19-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieViewProtocol {
    func showLoading()
    func hideLoading()
    func showMovieDetail(_ movie: Movie)}


class MovieViewController: UIViewController {
    
    var model: Movie
    var presenter: MoviePresenterProtocol?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = model.title
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    lazy var movieImage: UIImageView = {
        let image = SDImageCache.shared.imageFromMemoryCache(forKey: model.urlPoster.absoluteString)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var popularityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Popularity"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = String(model.popularity.rounded())
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "General review"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var overviewDetailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = model.overview
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var tagLineLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Tagline"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var tagLineDetailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = model.tagline
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    lazy var genresViews: TitleStackView = {
        let view = TitleStackView(title: "Genres",
                                  axis: .horizontal,
                                  distribution: .fillProportionally,
                                  spacing: 10.0,
                                  isScrollEnable: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var companyViews: TitleStackView = {
        let view = TitleStackView(title: "Production companies",
                                  axis: .vertical,
                                  distribution: .fillProportionally,
                                  spacing: 10.0,
                                  isScrollEnable: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
       let scroll = UIScrollView()
       scroll.translatesAutoresizingMaskIntoConstraints = false
       return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(model: Movie, presenter: MoviePresenterProtocol = MoviePresenter()) {
        self.model = model
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.attachView(view: self)
        self.title = "Pelicula"
        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.retreiveMovieDetail(id: model.id)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customNavigation()
    }
    
    func customNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    func setupView() {
        configureView()
        addHierarchy()
        addConstrains()
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
    
    func addHierarchy() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
               
        contentView.addSubview(titleLabel)
        contentView.addSubview(movieImage)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(popularityLabel)
        contentView.addSubview(tagLineLabel)
        contentView.addSubview(tagLineDetailLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewDetailLabel)
        contentView.addSubview(loadingView)
        contentView.addSubview(genresViews)
        contentView.addSubview(companyViews)
    }
    
    
    /// Constrains
    func addConstrains() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 30.0),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 50.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            .init(item: loadingView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0.0),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: movieImage, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: movieImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: movieImage, attribute: .trailing, multiplier: 1.0, constant: 30.0),
            .init(item: movieImage, attribute: .height, relatedBy: .equal, toItem: movieImage, attribute: .width, multiplier: (movieImage.frame.size.height / movieImage.frame.size.width), constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: popularityLabel, attribute: .top, relatedBy: .equal, toItem: movieImage, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: popularityLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: scoreLabel, attribute: .top, relatedBy: .equal, toItem: movieImage, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: scoreLabel, attribute: .leading, relatedBy: .equal, toItem: popularityLabel, attribute: .trailing, multiplier: 1.0, constant: 10.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: scoreLabel, attribute: .trailing, multiplier: 1.0, constant: 30.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: tagLineLabel, attribute: .top, relatedBy: .equal, toItem: popularityLabel, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: tagLineLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 30.0),
            .init(item: tagLineDetailLabel, attribute: .top, relatedBy: .equal, toItem: tagLineLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: tagLineDetailLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: tagLineDetailLabel, attribute: .trailing, multiplier: 1.0, constant: 30.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: overviewLabel, attribute: .top, relatedBy: .equal, toItem: tagLineDetailLabel, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: overviewLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: overviewDetailLabel, attribute: .top, relatedBy: .equal, toItem: overviewLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: overviewDetailLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: overviewDetailLabel, attribute: .trailing, multiplier: 1.0, constant: 30.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: genresViews, attribute: .top, relatedBy: .equal, toItem: overviewDetailLabel, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: genresViews, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: genresViews, attribute: .trailing, multiplier: 1.0, constant: 30.0),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: companyViews, attribute: .top, relatedBy: .equal, toItem: genresViews, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: companyViews, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: companyViews, attribute: .trailing, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: companyViews, attribute: .bottom, multiplier: 1.0, constant: 30.0)
        ])
   
    }
}


extension MovieViewController: MovieViewProtocol {
    func showLoading() {
        self.loadingView.startAnimating()
    }
    
    func hideLoading() {
        self.loadingView.stopAnimating()
    }
    
    func showMovieDetail(_ movie: Movie) {
        guard let genresMovie = movie.genres else { return }
        guard let companies = movie.productionCompanies else { return }
        for genre in genresMovie {
            let label = UILabel(frame: .zero)
            label.text = genre.name
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            genresViews.stackView.addArrangedSubview(label)
        }
        
        for companie in companies {
            let label = UILabel(frame: .zero)
            label.text = companie.name
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            companyViews.stackView.addArrangedSubview(label)
        }
        
        self.tagLineDetailLabel.text = movie.tagline
    }
}
