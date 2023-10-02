//
//  ViewController.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "selaammmm"
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

