//
//  LoginRequestDTO.swift
//  Authentication
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import Foundation

public struct LoginRequestDTO: Encodable {
    public let email: String
    public let password: String
}
