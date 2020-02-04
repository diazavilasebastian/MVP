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
    var spacing: CGFloat = 5.0
    var isScrollEnabled: Bool = true
    
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
        scroll.isScrollEnabled = self.isScrollEnabled
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
        stackView.spacing = self.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(title: String,
         axis: NSLayoutConstraint.Axis,
         distribution: UIStackView.Distribution,
         spacing: CGFloat,
         isScrollEnable: Bool,
         frame: CGRect = .zero) {
        self.title = title
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.isScrollEnabled = isScrollEnable
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
        self.scrollView.addSubview(stackView)
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
    }
    
    /// Constrains
    func addConstrains() {
        
        NSLayoutConstraint.activate([
           stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
           stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
           stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
           stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
           stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
           .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
           .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0),
           .init(item: self, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            .init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10.0),
            .init(item: self, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1.0, constant: 0),
            .init(item: self, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0)
        ])
               
    }
    
}
