//
//  BaseRouter.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import UIKit

class BaseRouter: NSObject, Router {
    private weak var owner: Coordinator?
    
    func setOwner(coordinator: Coordinator) {
        owner = coordinator
    }
    
    func push(_ type: CoordinatorRepresentable) {
        guard let owner = owner else { return }
        
        let destinationCoordinator = type.coordinator
        destinationCoordinator.isModal = false
        let viewController = owner.start(coordinator: destinationCoordinator)
        
        destinationCoordinator.navigationController = owner.navigationController
        destinationCoordinator.parent = owner
        
        owner.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ type: CoordinatorRepresentable) {
        guard let owner = owner else { return }
        
        let destinationCoordinator = type.coordinator
        destinationCoordinator.isModal = true
        let viewController = owner.start(coordinator: destinationCoordinator)
        
        let presentingNavigationController = UINavigationController(rootViewController: viewController)
        
        destinationCoordinator.navigationController = presentingNavigationController
        destinationCoordinator.parent = owner
        presentingNavigationController.modalPresentationStyle = .fullScreen
        owner.navigationController?.present(presentingNavigationController, animated: true)
    }
    
    func dismiss() {
        guard let owner = owner else { return }
        owner.dismiss()
        owner.navigationController?.dismiss(animated: true)
    }
    
    func pop() {
        guard let owner = owner else { return }
        owner.dismiss()
        owner.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("DEINIT \(NSStringFromClass(self.classForCoder).split(separator: ".")[1])")
    }
}
