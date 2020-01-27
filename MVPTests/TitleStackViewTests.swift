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
                    let frame = CGRect(x: 0, y: 0, width: 320, height: 40)
                    sut = TitleStackView(title: "Genres", axis: .horizontal, distribution: .fillEqually, frame: frame)
                    expect(sut) == recordSnapshot()
                }
            }
        }
    }
    
}
