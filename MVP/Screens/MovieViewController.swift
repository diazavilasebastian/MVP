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
    
    lazy var titleLabel: UILabel = {
        let title : UILabel = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.text = self.model.title
        return title
    }()
    
    
    lazy var backgroundImage : UIImageView = {
        let image = SDImageCache.shared.imageFromMemoryCache(forKey: model.urlPoster.absoluteString)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var backgroundBlur : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    init(model: Movie) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.title = model.title
        self.configView()
        self.addConstrains()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configView() {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(backgroundBlur)
        self.view.addSubview(titleLabel)
        self.view.backgroundColor = .white
    }
    
    func addConstrains() {
        
        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: 30),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 30),
            .init(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            .init(item: backgroundImage, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: 0),
            .init(item: backgroundImage, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: backgroundImage, attribute: .trailing, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: backgroundImage, attribute: .bottom, multiplier: 1.0, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: backgroundBlur, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: 0),
            .init(item: backgroundBlur, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: backgroundBlur, attribute: .trailing, multiplier: 1.0, constant: 0),
            .init(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: backgroundBlur, attribute: .bottom, multiplier: 1.0, constant: 0)
        ])
    }
}
