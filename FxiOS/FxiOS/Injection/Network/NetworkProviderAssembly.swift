//
//  NetworkProviderAssembler.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 7.10.2023.
//

import Foundation
import FxNetwork
import Swinject
import SwinjectAutoregistration
import Alamofire

final class NetworkInterceptor: RequestInterceptor {
}

final class NetworkProviderAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister([EventMonitor].self) { _ in
            []
        }.inObjectScope(.weak)
        container.autoregister(URLSessionConfiguration.self) { _ in
            URLSessionConfiguration.default
        }
        container.autoregister(RequestInterceptor.self, initializer: NetworkInterceptor.init).inObjectScope(.weak)
        container.autoregister(NetworkManagerProtocol.self, initializer: NetworkManager.init).inObjectScope(.container)
        container.autoregister(HttpPropertyProviderProtocol.self, initializer: DefaultHttpPropertyProvider.init).inObjectScope(.container)
    }
}
