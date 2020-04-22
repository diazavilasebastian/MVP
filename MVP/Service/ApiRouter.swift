//
//  ApiRouter.swift
//  MVP
//
//  Created by ITAU on 06-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter {
    
    case getMovie(id: Int)
    case getTopRated
    case getUpcoming
    case getPopular(page: Int)

    var path: String {
        switch self {
        case .getMovie(let id):
            return "\(ApiRouter.baseURLString)/\(id)?"
        case .getTopRated:
            return "\(ApiRouter.baseURLString)/top_rated?"
        case .getUpcoming:
            return "\(ApiRouter.baseURLString)/upcoming?"
        case .getPopular:
            return "\(ApiRouter.baseURLString)/popular?"
        }
    }

    var parameters: [String : Any] {
        var param: [String : Any] = [
            "api_key": "\(ApiRouter.ApiKey)",
            "language": "en-US"
        ]
        switch self {
        case .getPopular(let page):
            param["page"] = page
         default:
            break
        }
        return param
    }
}

extension ApiRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try self.path.asURL()
        let request = URLRequest(url: url)
        return try URLEncoding.queryString.encode(request, with: parameters)
    }
}

extension ApiRouter {
    static let baseURLString = "https://api.themoviedb.org/3/movie"
    static let ApiKey = "6893e0b3a6030f46d850edf87283de46"
}
