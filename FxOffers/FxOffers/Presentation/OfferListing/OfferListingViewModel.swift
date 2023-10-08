//
//  OfferListingViewModel.swift
//  FxOffers
//
//  Created by Salihcan Kahya on 7.10.2023.
//

import Foundation
import SwiftUI

public protocol TestNetworkProtocol {
    func getOffers()
}

struct MockNetwork: TestNetworkProtocol {
    func getOffers() {
        
    }
}

public final class OfferListingViewModel: ObservableObject {
    
    private let networkRequest: TestNetworkProtocol
    
    public init(networkRequest: TestNetworkProtocol) {
        self.networkRequest = networkRequest
    }
    
    public func getOffers() {
        networkRequest.getOffers()
    }
}
