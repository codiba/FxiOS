//
//  HTTPHeaderFields.swift
//  FxNetwork
//
//  Created by Salihcan Kahya on 6.10.2023.
//

import Alamofire

public enum HTTPHeaderFields {
    case contentType
    
    public var value: HTTPHeader {
        switch self {
            case .contentType:
                return HTTPHeader(name: "Content-Type", value: "application/json; charset=utf-8")
        }
    }
}
