//
//  TitleStackViewTests.swift
//  MVPTests
//
//  Created by Sebastian Diaz Avila on 26-01-20.
//  Copyright © 2020 ITAU. All rights reserved.
//

import Foundation
import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import MVP

class TitleStackViewTests: QuickSpec {
    
    override func spec() {
        debugPrint("")
        describe("TitleStackView") {
            context("when initilized") {
                it("have the spected layout"){
                    let sut: TitleStackView
                    let frame = CGRect(x: 0, y: 0, width: 320, height: 100)
                    sut = TitleStackView(title: "Genres", axis: .vertical, distribution: .fillEqually, frame: frame)
                    
                    let genres = ["HOLA","HOLA","HOLA","HOLA","HOLA","HOLA"]
                    genres.map {
                        let label = UILabel(frame: .zero)
                        label.text = $0
                        label.textColor = .white
                        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                        sut.stackView.addArrangedSubview(label)
                    }
                    expect(sut) == snapshot()
                }
            }
        }
    }
    
}
