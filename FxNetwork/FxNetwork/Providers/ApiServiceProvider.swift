//
//  ApiServiceProvider.swift
//  FxNetwork
//
//  Created by Salihcan Kahya on 6.10.2023.
//

import Alamofire
import Foundation

open class ApiServiceProvider: URLRequestConvertible {
    
    private let method: HTTPMethod
    private let httpPropertyProvider: HttpPropertyProviderProtocol

    private var path: String?
    private var data: Encodable?
    
    public init(httpPropertyProvider: HttpPropertyProviderProtocol, method: HTTPMethod = .get, path: String? = nil, data: Encodable? = nil) {
        self.method = method
        self.path = path
        self.data = data
        self.httpPropertyProvider = httpPropertyProvider
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url = try httpPropertyProvider.getBaseUrl().asURL()
        
        if let path = path {
            url = url.appendingPathComponent(path)
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!

        if let defaultQueryParams = httpPropertyProvider.getDefaultQueryParams() {
            urlComponents.queryItems = defaultQueryParams
        }

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        request.headers = headers
        request.cachePolicy = .reloadIgnoringCacheData
        
        return try encoding.encode(request, with: params)
    }
    
    // MARK: - Encoding -
    private var encoding: ParameterEncoding {
        httpPropertyProvider.getParameterEncoding(by: method)
    }
    
    private var params: Parameters? {
        return data?.asDictionary()
    }
    
    private var headers: HTTPHeaders {
        httpPropertyProvider.getHttpHeaders()
    }
}
