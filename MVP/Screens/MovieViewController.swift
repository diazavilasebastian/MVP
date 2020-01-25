//
//  MovieViewController.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 19-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import UIKit
import SDWebImage

class MovieViewController: UIViewController {
    
    var model: Movie
    
    lazy var movieImage: UIImageView = {
        let image = SDImageCache.shared.imageFromMemoryCache(forKey: model.urlPoster.absoluteString)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = String(model.popularity.rounded())
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = model.title
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
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
    
    init(model: Movie) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.title = "Pelicula"
        self.configView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    func configView() {
        self.view.backgroundColor = .black
       
        self.addHierarchy()
        self.addConstrains()
    }
    
    func addHierarchy() {
        self.scrollView.addSubview(contentView)
        self.view.addSubview(scrollView)
               
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(movieImage)
        self.contentView.addSubview(scoreLabel)
    }
    
    
    
    func addConstrains() {
        
        NSLayoutConstraint.activate([
            .init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        ])
        NSLayoutConstraint.activate([
            .init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 30.0),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 30.0)
        ])
        
        
        NSLayoutConstraint.activate([
            .init(item: movieImage, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: movieImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: movieImage, attribute: .trailing, multiplier: 1.0, constant: 30.0),
            .init(item: movieImage, attribute: .height, relatedBy: .equal, toItem: movieImage, attribute: .width, multiplier: (movieImage.frame.size.height / movieImage.frame.size.width), constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: scoreLabel, attribute: .top, relatedBy: .equal, toItem: movieImage, attribute: .bottom, multiplier: 1.0, constant: 30.0),
            .init(item: scoreLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 30.0),
            .init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: scoreLabel, attribute: .trailing, multiplier: 1.0, constant: 30.0)
        ])
    }
}
