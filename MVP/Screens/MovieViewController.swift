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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var scoreView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(red:1.00, green:0.75, blue:0.00, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(Int(model.popularity.rounded()))
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        label.textAlignment = .center
        return label
    }()
    
    init(model: Movie) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.title = model.title
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
    }
    
    func configView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(movieImage)
        self.view.addSubview(scoreView)
        self.scoreView.addSubview(scoreLabel)
        
        
        self.addConstrains()
    }
    
    func addConstrains() {

        NSLayoutConstraint.activate([
            .init(item: movieImage, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: 20.0),
            .init(item: movieImage, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: movieImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 200),
            .init(item: movieImage, attribute: .height, relatedBy: .equal, toItem: movieImage, attribute: .width, multiplier: (CGFloat(1.5 / 1.0)), constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: scoreView, attribute: .top, relatedBy: .equal, toItem: movieImage, attribute: .top, multiplier: 1.0, constant: 0),
            .init(item: scoreView, attribute: .leading, relatedBy: .equal, toItem: movieImage, attribute: .trailing, multiplier: 1.0, constant: 20.0),
            .init(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: scoreView, attribute: .trailing, multiplier: 1.0, constant: 20.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: scoreLabel, attribute: .top, relatedBy: .equal, toItem: scoreView, attribute: .top, multiplier: 1.0, constant: 20.0),
            .init(item: scoreLabel, attribute: .leading, relatedBy: .equal, toItem: scoreView, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: scoreView, attribute: .trailing, relatedBy: .equal, toItem: scoreLabel, attribute: .trailing, multiplier: 1.0, constant: 20.0),
            .init(item: scoreView, attribute: .bottom, relatedBy: .equal, toItem: scoreLabel, attribute: .bottom, multiplier: 1.0, constant: 20.0),
        ])
    }
}
