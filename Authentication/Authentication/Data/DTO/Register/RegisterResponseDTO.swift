//
//  RegisterResponseDTO.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation

public struct RegisterResponseDTO: Decodable {
    public init(token: String) {
        self.token = token
    }
    
    let token: String
}
