//
//  HorizontalTableViewController.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/1/22.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import Foundation
import UIKit

class HorizontalTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tableView = HorizontalTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.cellType = TextCell.self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: 80)
        ])
        tableView.delegate = self
    }
}

extension HorizontalTableViewController: HorizontalTableViewDelegate {
    func tableView(_ tableView: HorizontalTableView, widthForItemAt index: Int) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: HorizontalTableView, cellForItemAt index: Int) -> HorizontalTableViewCell {
        let cell = tableView.dequeueCell()
        if let textCell = cell as? TextCell {
            textCell.setText("index: \(index)")
        }
        return cell
    }
    
    func numberOfItems(in tableView: HorizontalTableView) -> Int {
        return 30
    }
}
