//
//  TitleStackView.swift
//  MVP
//
//  Created by Sebastian Diaz Avila on 26-01-20.
//  Copyright © 2020 ITAU. All rights reserved.
//

import Foundation
import UIKit

class TitleStackView: UIView {
    
    var title: String
    var axis: NSLayoutConstraint.Axis
    var distribution: UIStackView.Distribution
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = self.title
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = self.axis
        stackView.distribution = self.distribution
        return stackView
    }()
    
    init(title: String,
         axis: NSLayoutConstraint.Axis,
         distribution: UIStackView.Distribution,
         frame: CGRect = .zero) {
        self.title = title
        self.axis = axis
        self.distribution = distribution
        super.init(frame: frame)
        self.setupView()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TitleStackView {
    
    func setupView() {
        configureView()
        addHierarchy()
        addConstrains()
    }
    
    func configureView() {
        self.backgroundColor = .black
    }
    
    func addHierarchy() {        
        self.addSubview(titleLabel)
    }
    
    
    /// Constrains
    func addConstrains() {
        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0),
            .init(item: self, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0),
            .init(item: self, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 0)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 751), for: .vertical)
    }
    
}
