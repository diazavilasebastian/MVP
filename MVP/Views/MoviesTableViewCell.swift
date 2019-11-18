//
//  MovieListTableViewCell.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 14-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {
    
    var movie: MovieResume? {
        didSet {
            movieNameLabel.text = movie?.title
            poster.sd_setImage(with: movie?.urlPoster, completed: nil )
        }
    }
    
    private lazy var movieNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private lazy var poster: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstrains()
        self.clipsToBounds = true
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstrains() {

        self.addSubview(poster)
        self.addSubview(movieNameLabel)

        NSLayoutConstraint.activate([
            .init(item: poster, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            .init(item: poster, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0),
            .init(item: self, attribute: .right, relatedBy: .equal, toItem: poster, attribute: .right, multiplier: 1.0, constant: 0),
            .init(item: self, attribute: .trailing, relatedBy: .equal, toItem: poster, attribute: .trailing, multiplier: 1.0, constant: 0),
            .init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 100)
        ])

        NSLayoutConstraint.activate([
            .init(item: movieNameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0),
            .init(item: movieNameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
        ])

    }
    
}
