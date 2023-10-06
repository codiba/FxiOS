//
//  HostingViewController.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 3.10.2023.
//

import UIKit
import SwiftUI

final class HostingViewController<Content>: UIHostingController<Content> where Content: View {
    var dismissCallback: (() -> Void)? = nil
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        guard parent == nil else { return }
        dismissCallback?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("DEINIT \(NSStringFromClass(self.classForCoder))")
    }
}
