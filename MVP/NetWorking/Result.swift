//
//  Result.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import Foundation

enum Result<M,E> {
    case success(M)
    case error(E)
    case timeOut
}
