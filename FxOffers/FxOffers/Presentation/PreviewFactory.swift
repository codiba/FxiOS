//
//  PreviewFactory.swift
//  FxOffers
//
//  Created by Salihcan Kahya on 7.10.2023.
//

import Foundation

struct PreviewFactory {
    static func getOfferListing() -> OfferListingView {
        OfferListingView(viewModel: .init(networkRequest: MockNetwork()))
    }
}

