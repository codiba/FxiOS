//
//  ServerErrorProtocol.swift
//  FxNetwork
//
//  Created by Salihcan Kahya on 6.10.2023.
//

import Foundation

public protocol ServerErrorProtocol: Error, Decodable {
    init(description: String)
}
