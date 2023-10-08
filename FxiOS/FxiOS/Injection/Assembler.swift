//
//  Assembler.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import Swinject

extension Assembler {
    static let shared: Assembler = {
        let assembler = Assembler()
        assembler.apply(assembly: NetworkProviderAssembly())
        assembler.apply(assembly: AuthenticationAssembler())
        assembler.apply(assembly: RegisterAssembly())
        assembler.apply(assembly: LoginAssembly())
        assembler.apply(assembly: FxOfferListingAssembly())
        return assembler
    }()
}

protocol GetResolver {
    func returnResolver() -> Resolver
}

extension GetResolver {
    func returnResolver() -> Resolver {
        Assembler.shared.resolver
    }
}
