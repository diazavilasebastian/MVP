//
//  MovieListTableViewCell.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 14-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation
import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    var movie: MovieResume? {
        didSet {
            movieNameLabel.text = movie?.title
        }
    }
    
    private let movieNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(movieNameLabel)
        self.setupConstrains()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstrains() {
        NSLayoutConstraint.activate([
            .init(item: movieNameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30),
            .init(item: movieNameLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            .init(item: movieNameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 30),
            .init(item: self, attribute: .bottom, relatedBy: .equal, toItem: movieNameLabel, attribute: .bottom, multiplier: 1.0, constant: 30),
        ])
    }
    
}
