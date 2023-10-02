//
//  BaseCoordinator.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import Foundation
import UIKit
import SwiftUI

class BaseCoordinator<V,R>: NSObject, Coordinator {
    var navigationController: UINavigationController?
    let id: UUID = .init()
    var isModal: Bool = false
    weak var parent: Coordinator?
    
    private var childs: [Coordinator] = []
    public let viewModel: V
    public let router: R
    
    init(viewModel: V, router: R) {
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
            .toolbar {
                if isModal {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button { [weak self] in
                            self?.navigationController?.dismiss(animated: true)
                            self?.dismiss()
                        } label: {
                            Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 25, height: 25)
                        }
                    }
                }
            }
        
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
