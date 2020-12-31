//
//  ViewController.swift
//  RobotCheck
//
//  Created by yuxiao on 2020/12/31.
//  Copyright © 2020 Yulong Xiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hello world"
        label.textColor = .red
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 12)
        ])
    }
}

