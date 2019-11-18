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
        case let .getMovie(id):
            return "\(ApiRouter.baseURLString)/\(id)?api_key=\(ApiRouter.ApiKey)&language=es-US"
        case .getTopRated:
            return "\(ApiRouter.baseURLString)/top_rated?api_key=\(ApiRouter.ApiKey)&language=en-US&page=1"
        case .getUpcoming:
            return "\(ApiRouter.baseURLString)/upcoming?api_key=\(ApiRouter.ApiKey)&language=en-US&page=1"
        case let .getPopular(page):
            return "\(ApiRouter.baseURLString)/popular?api_key=\(ApiRouter.ApiKey)&language=en-US&page=\(page)"
        }
    }

    var parameters: [String : Any] {
        return [:]
    }
}

extension ApiRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try self.path.asURL()
        let request = URLRequest(url: url)
        return try URLEncoding.default.encode(request, with: self.parameters)
    }
}

extension ApiRouter {
    static let baseURLString = "https://api.themoviedb.org/3/movie"
    static let ApiKey = "adde2ca99aaf9c49bde338ab2cee56a0"
}
