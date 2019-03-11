//
//  Request.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/10/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    func didCompleteWithResponse(_ response: Any?, request: Int)
    func didFailWithError(_ error: Error, request: Int)
}
