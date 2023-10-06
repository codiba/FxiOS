//
//  NetworkManager.swift
//  FxNetwork
//
//  Created by Salihcan Kahya on 6.10.2023.
//

import Foundation
import Alamofire
import Combine
import Foundation

public final class NetworkManager: NetworkMananagerProtocol {
    
    private var session: Session
    private let decoder = JSONDecoder()
    
    public init(configuration: URLSessionConfiguration, interceptor: RequestInterceptor, eventMonitors: [EventMonitor]) {
        session = Session(configuration: configuration, startRequestsImmediately: true, interceptor: interceptor, eventMonitors: eventMonitors)
    }
    
    public func execute<Response: Decodable>(with urlRequest: URLRequestConvertible) -> AnyPublisher<Response, Error> {
        session.request(urlRequest)
            //.validate()
            .publishData()
            .compactMap { $0.result }
            .tryMap { (result: Result<Data, AFError>) -> Response in
                switch result {
                case .success(let data):
                    do {
                        return try self.decoder.decode(Response.self, from: data)
                    } catch {
                        throw error
                    }
                case .failure(let failure):
                    throw failure
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func execute(with urlRequest: URLRequestConvertible) -> AnyPublisher<Data, Error> {
        session.request(urlRequest)
        //.validate() // for now, do not check for status code. Later will be added custom validatators here.
            .publishData()
            .compactMap { $0.result }
            .tryMap { (result: Result<Data, AFError>) -> Data in
                switch result {
                case .success(let data):
                    return data
                case .failure(let failure):
                    throw failure
                }
            }
            .eraseToAnyPublisher()
    }
}
