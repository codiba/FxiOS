//
//  NetworkMananagerProtocol.swift
//  FxNetwork
//
//  Created by Salihcan Kahya on 6.10.2023.
//

import Alamofire
import Combine
import Foundation

public protocol NetworkMananagerProtocol {
    func execute<Response: Decodable>(with urlRequest: URLRequestConvertible) -> AnyPublisher<Response, Error>
    func execute(with urlRequest: URLRequestConvertible) -> AnyPublisher<Data, Error>
}
