//
//  Coordinator.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var navigationController: UINavigationController? { get set }
    var isModal: Bool { get set }
    var id: UUID { get }
    
    func start() -> UIViewController
    func start(coordinator: Coordinator) -> UIViewController
    func dismiss()
    func removeChild(_ coordinator: Coordinator)
}
