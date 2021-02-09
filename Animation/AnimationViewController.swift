//
//  AnimationViewController.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/2/2.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    var mainView: UIView?
    var button: UIButton?
    var layerButton: UIButton?
    var watchButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tempView = AnimationView()
        tempView.backgroundColor = .red
        tempView.frame = CGRect(x: 20, y: 60, width: 60, height: 60)
        view.addSubview(tempView)
        mainView = tempView
        
        let tempButton = UIButton()
        tempButton.setTitle("Animation", for: .normal)
        tempButton.frame = CGRect(x: 20, y: 140 + 300, width: 100, height: 60)
        tempButton.backgroundColor = .darkGray
        tempButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        view.addSubview(tempButton)
        button = tempButton
        
        let tempButton1 = UIButton()
        tempButton1.setTitle("see layer", for: .normal)
        tempButton1.frame = CGRect(x: 20, y: 220 + 300, width: 100, height: 60)
        tempButton1.backgroundColor = .darkGray
        tempButton1.addTarget(self, action: #selector(layerButtonDidTap), for: .touchUpInside)
        view.addSubview(tempButton1)
        layerButton = tempButton1
        
        let tempButton2 = UIButton()
        tempButton2.setTitle("view frame", for: .normal)
        tempButton2.frame = CGRect(x: 20, y: 300 + 300, width: 100, height: 60)
        tempButton2.backgroundColor = .darkGray
        tempButton2.addTarget(self, action: #selector(watchButtonDidTap), for: .touchUpInside)
        view.addSubview(tempButton2)
        layerButton = tempButton1
        
        
    }
    
    @objc private func buttonDidTap() {
        let animation = UIViewPropertyAnimator(duration: 10, curve: .linear) {
            self.mainView!.center.y += 300
        }
        
//        animation.addAnimations({
//            self.mainView!.center.x += 100
//        }, delayFactor: 0.99)
        
        animation.startAnimation()
    }
    
    @objc private func layerButtonDidTap() {
        print("layer: \(mainView!.layer)")
        print("prezention layer \(mainView!.layer.presentation())")
        print("model layer: \(mainView!.layer.model())")
        print("other model layer: \(mainView!.layer.presentation()?.model())")
    }
    
    @objc private func watchButtonDidTap() {
        if let view = mainView {
            print("button location: \(view.frame)")
        }
    }
}
