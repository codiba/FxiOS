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
        "https://05f06db4-3a88-4a28-a669-caec169e66b8.mock.pstmn.io"
    }
}
