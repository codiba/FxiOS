//
//  LoginCoordinator.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import UIKit
import SwiftUI
import Authentication

protocol CoordinatorRepresentable {
    var coordinator: Coordinator { get }
}

protocol Router {
    func setOwner(coordinator: Coordinator)
    func push(_ type: CoordinatorRepresentable)
    func present(_ type: CoordinatorRepresentable)
    func dismiss()
    func pop()
}

class BaseRouter: Router {
    private weak var owner: Coordinator?
    
    func setOwner(coordinator: Coordinator) {
        owner = coordinator
    }
    
    func push(_ type: CoordinatorRepresentable) {
        guard let owner = owner else { return }
        
        let destinationCoordinator = type.coordinator
        let viewController = owner.start(coordinator: destinationCoordinator)
        
        destinationCoordinator.navigationController = owner.navigationController
        destinationCoordinator.parent = owner
        
        owner.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ type: CoordinatorRepresentable) {
        guard let owner = owner else { return }
        
        let destinationCoordinator = type.coordinator
        let viewController = owner.start(coordinator: destinationCoordinator)
        
        let presentingNavigationController = UINavigationController(rootViewController: viewController)
        
        destinationCoordinator.navigationController = presentingNavigationController
        destinationCoordinator.parent = owner
        
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
}

protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var navigationController: UINavigationController? { get set }
    var id: UUID { get }
    
    func start() -> UIViewController
    func start(coordinator: Coordinator) -> UIViewController
    func dismiss()
    func removeChild(_ coordinator: Coordinator)
    
}

class HostingViewController<Content>: UIHostingController<Content> where Content: View {
    var dismissCallback: (() -> Void)? = nil
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        guard parent == nil else { return }
        dismissCallback?()
    }
    
    deinit {
        print("DEINIT \(NSStringFromClass(self.classForCoder).split(separator: ".")[0])")
    }
}

open class BaseCoordinator<V,R>: NSObject, Coordinator {
    var navigationController: UINavigationController?
    let id: UUID = .init()
    weak var parent: Coordinator?
    
    private var childs: [Coordinator] = []

    public let viewModel: V
    public let router: R
    
    public init(viewModel: V, router: R) {
        self.viewModel = viewModel
        self.router = router
        super.init()
        print("Coordinator started \(self)")
        prepareRouter()
    }
    
    private func prepareRouter() {
        (router as? Router)?.setOwner(coordinator: self)
    }
    
    func start() -> UIViewController {
        let view = makeView()
        let viewController = HostingViewController(rootView: view)
        viewController.dismissCallback = handleDismiss
        return viewController
    }
    
    func start(coordinator: Coordinator) -> UIViewController {
        childs.append(coordinator)
        return coordinator.start()
    }
    
    func dismiss() {
        removeChilds()
        parent?.removeChild(self)
        
    }
    
    open func makeView() -> AnyView {
        fatalError()
    }
    
    private lazy var handleDismiss: () -> Void = { [weak self] in
        self?.dismiss()
    }
    
    private func removeChilds() {
        let childArray = childs
        
        childArray.forEach { child in
            child.dismiss()
        }
        
        childs = []
    }
    
    func removeChild(_ coordinator: Coordinator) {
        guard let index = childs.firstIndex(where: { coordinator.id == $0.id }) else { return }
        childs.remove(at: index)
    }
    
    deinit {
        print("DEINIT \(NSStringFromClass(self.classForCoder).split(separator: ".")[1])")
    }
}

enum Coordinators: CoordinatorRepresentable, GetResolver {
    case login
    case register
    
    var coordinator: Coordinator {
        switch self {
        case .login:
            return resolve(LoginCoordinator.self)
        case .register:
            return resolve(LoginCoordinator.self)
        }
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        returnResolver().resolve(T.self)!
    }
}

final class LoginRouter: BaseRouter {
    func gotoRegister() {
        present(Coordinators.register)
    }
    
    func gotoHome() {
        push(Coordinators.login)
    }
}

final class LoginCoordinator: BaseCoordinator<LoginViewModel, LoginRouter> {
    override func makeView() -> AnyView {
        return LoginView(viewModel: viewModel, action: { [weak self] action in
            switch action {
            case .goToRegister:
                self?.router.gotoRegister()
            case .loginSuccess:
                self?.router.gotoHome()
            }
        }).anyView
    }
}


extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}
