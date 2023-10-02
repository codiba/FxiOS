//
//  Router.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation

protocol Router {
    func setOwner(coordinator: Coordinator)
    func push(_ type: CoordinatorRepresentable)
    func present(_ type: CoordinatorRepresentable)
    func dismiss()
    func pop()
}
