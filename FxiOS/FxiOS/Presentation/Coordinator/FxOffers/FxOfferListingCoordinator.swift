//
//  FxOfferListingCoordinator.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 8.10.2023.
//

import FxOffers
import SwiftUI

final class OfferListingRouter: BaseRouter, OfferListingRouterProtocol {
    func goToEditing() {
        
    }
    
    func goToAdding() {
        
    }
}

final class FxOfferListingCoordinator: BaseCoordinator<OfferListingViewModel, OfferListingRouterProtocol> {
    override func makeView() -> AnyView {
        return OfferListingView(viewModel: viewModel).anyView
    }
}
