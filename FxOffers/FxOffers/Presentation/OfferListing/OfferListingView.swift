//
//  OfferListingView.swift
//  FxOffers
//
//  Created by Salihcan Kahya on 7.10.2023.
//

import SwiftUI

public struct OfferListingView: View {
    @StateObject var viewModel: OfferListingViewModel
    
    public init(viewModel: OfferListingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                viewModel.getOffers()
            }
    }
}

#Preview {
    PreviewFactory.getOfferListing()
}
