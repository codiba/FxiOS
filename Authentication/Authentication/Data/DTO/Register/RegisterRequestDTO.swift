//
//  RegisterRequestDTO.swift
//  Authentication
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation

public struct RegisterRequestDTO: Encodable {
    public let email: String
    public let password: String
}
