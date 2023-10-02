//
//  LoginResponseDTO.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import Foundation

public struct LoginResponseDTO: Decodable {
    public init(token: String) {
        self.token = token
    }
    
    let token: String
}
