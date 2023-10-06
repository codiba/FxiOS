//
//  DefaultHttpPropertyProvider.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 6.10.2023.
//

import Foundation
import FxNetwork

final class DefaultHttpPropertyProvider: HttpPropertyProviderProtocol {
    
    func getDefaultQueryParams() -> [URLQueryItem]? {
        // TODO: Take user token from local db|keychain|coredata to make request
        []
    }
    
    func getBaseUrl() -> String {
        ""
    }
}
