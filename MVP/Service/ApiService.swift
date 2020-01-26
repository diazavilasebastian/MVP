//
//  ApiService.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation
import Alamofire


protocol ServiceProtocol {

    typealias listMoviesResult = (Result<PageMovies,ErrorService>) -> Void
    typealias movieResult = (Result<Movie,ErrorService>) -> Void

    func getMovie(id: Int, completition: @escaping movieResult )
    func getTopRated(completition: @escaping listMoviesResult)
    func getUpcoming(completition: @escaping listMoviesResult)
    func getPopular(page: Int, completition: @escaping listMoviesResult)
}

enum ErrorService: Error{
    case unknow(Error)
    case timeOut
    case notInternet
    case parseModel(Error)
}


class ApiService: ServiceProtocol {

    let manager: SessionManager
    let configuration: URLSessionConfiguration

    init() {
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getTopRated(completition: @escaping listMoviesResult) {
        manager.request(ApiRouter.getTopRated).validate().responseData { response in
            completition(self.handlerResponse(response: response))
        }
    }

    func getUpcoming(completition: @escaping listMoviesResult) {
        manager.request(ApiRouter.getUpcoming).validate().responseData { response in
            completition(self.handlerResponse(response: response))
        }
    }

    func getPopular(page: Int, completition: @escaping listMoviesResult ) {
        manager.request(ApiRouter.getPopular(page: page)).validate().responseData { response in
            completition(self.handlerResponse(response: response))
        }
    }

    func getMovie(id: Int, completition: @escaping movieResult ) {
        debugPrint(id)
        manager.request(ApiRouter.getMovie(id: id)).validate().responseData { response in
            completition(self.handlerResponse(response: response))
        }
    }

    private func handlerResponse<Model: Codable>(response: DataResponse<Data>) -> Result<Model,ErrorService> {
        switch response.result {
        case .success(let data):
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                return .success(model)
            } catch let error {
                return .error(.parseModel(error))
            }
        case .failure(let error):
            switch error._code {
            case NSURLErrorTimedOut:
                return .timeOut
            case NSURLErrorNotConnectedToInternet:
                return .error(.notInternet)
            default:
                return .error(.unknow(error))
            }
        }
    }

}
