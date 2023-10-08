//
//  FxOfferListingAssembly.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 8.10.2023.
//

import SwinjectAutoregistration
import Swinject
import FxOffers
import FxNetwork
import Combine

final class FxOfferGetRequestProvider: ApiServiceProvider {
    init(httpPropertyProvider: HttpPropertyProviderProtocol) {
        super.init(httpPropertyProvider: httpPropertyProvider, method: .get, path: "/getOffers")
    }
}

final class FxNetworkTest: TestNetworkProtocol, GetResolver {
    private let networkManager: NetworkManagerProtocol
    private var cancallables: Set<AnyCancellable> = .init()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    
    func getOffers() {
        let provider = returnResolver().resolve(FxOfferGetRequestProvider.self)!
        networkManager.execute(with: provider)
            .sink { completion in
                print(completion)
            } receiveValue: { data in
            }
            .store(in: &cancallables)
    }
}

struct FxOfferListingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister(FxOfferGetRequestProvider.self, initializer: FxOfferGetRequestProvider.init).inObjectScope(.transient)
        container.autoregister(TestNetworkProtocol.self, initializer: FxNetworkTest.init).inObjectScope(.container)
        container.autoregister(OfferListingViewModel.self, initializer: OfferListingViewModel.init).inObjectScope(.weak)
        container.autoregister(OfferListingRouterProtocol.self, initializer: OfferListingRouter.init).inObjectScope(.weak)

        container.autoregister(FxOfferListingCoordinator.self, initializer: FxOfferListingCoordinator.init).inObjectScope(.weak)

        container.autoregister(FxOfferListingCoordinator.self, initializer: FxOfferListingCoordinator.init).inObjectScope(.weak)
    }
}
