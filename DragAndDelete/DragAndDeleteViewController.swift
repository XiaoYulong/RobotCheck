//
//  DragAndDeleteViewController.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/1/23.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import UIKit

class DragAndDeleteViewController: UIViewController {
    
    enum State {
        case fixed
        case moving
        case deleted
    }
    
    private let itemView: UIView
    private let trashCan: UIView
    private let panGestureRecognizer: UIPanGestureRecognizer
    
    private let littleDot = UIView()
    
    private var state: State = .fixed
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        itemView = UIView()
        trashCan = UIView()
        panGestureRecognizer = UIPanGestureRecognizer()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemView.backgroundColor = .red
        itemView.translatesAutoresizingMaskIntoConstraints = false
        trashCan.backgroundColor = .green
        trashCan.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemView)
        view.addSubview(trashCan)
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemView.widthAnchor.constraint(equalToConstant: 40),
            itemView.heightAnchor.constraint(equalToConstant: 40),
            trashCan.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            trashCan.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            trashCan.widthAnchor.constraint(equalToConstant: 40),
            trashCan.heightAnchor.constraint(equalToConstant: 40)
        ])
        panGestureRecognizer.addTarget(self, action: #selector(handleGesture(gestureRecognizer:)))
        view.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(littleDot)
        littleDot.backgroundColor = .black
        littleDot.bounds = CGRect(x: 0, y: 0, width: 4, height: 4)
    }
    
    @objc private func handleGesture(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .began {
            littleDot.center = gestureRecognizer.location(in: view)
            if state == .fixed {
                print(gestureRecognizer.location(in: view))
                print(itemView.frame)
                if itemView.frame.contains(gestureRecognizer.location(in: view)) {
                    state = .moving
                }
            }
        } else if gestureRecognizer.state == .changed {
            if state == .moving {
                itemView.center = gestureRecognizer.location(in: view)
                if trashCan.frame.intersects(itemView.frame) {
                    itemView.isHidden = true
                    state = .deleted
                }
            }
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            if state == .moving {
                state = .fixed
            }
        }
    }
}
