//
//  Companie.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

struct Company: Codable {

    var id: Int
    var logoPath: String?
    var name: String
    var originCountry: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }

}
