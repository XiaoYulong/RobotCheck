//
//  TransformViewController.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/2/1.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import UIKit

class TransformViewController: UIViewController {
    
    var view1: UIView?
    var view2: UIView?
    var view3: UIView?
    
    var view1Rotated = false
    var view2Transformed = false
    var view3Transformed = false
    
    var rotateView1Button: UIButton?
    var view2Button: UIButton?
    var view3Button: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1 = UIView()
        view1?.frame = CGRect(x: 20, y: 60, width: 40, height: 40)
        view1?.backgroundColor = .red
        view.addSubview(view1!)
        
        view2 = UIView()
        view2?.frame = CGRect(x: 20, y: 120, width: 40, height: 40)
        view2?.backgroundColor = .red
        view.addSubview(view2!)
        
        view3 = UIView()
        view3?.frame = CGRect(x: 20, y: 180, width: 40, height: 40)
        view3?.backgroundColor = .red
        view.addSubview(view3!)
        
        rotateView1Button = UIButton()
        rotateView1Button?.backgroundColor = .darkGray
        rotateView1Button?.setTitle("rotate view 1", for: .normal)
        rotateView1Button?.frame = CGRect(x: 20, y: 240, width: 120, height: 40)
        view.addSubview(rotateView1Button!)
        rotateView1Button?.addTarget(self, action: #selector(rotateView1), for: .touchUpInside)
        
        view2Button = UIButton()
        view2Button?.backgroundColor = .darkGray
        view2Button?.setTitle("move then rotate", for: .normal)
        view2Button?.frame = CGRect(x: 20, y: 300, width: 140, height: 40)
        view.addSubview(view2Button!)
        view2Button?.addTarget(self, action: #selector(transformView2), for: .touchUpInside)
        
        view3Button = UIButton()
        view3Button?.backgroundColor = .darkGray
        view3Button?.setTitle("rotate then move", for: .normal)
        view3Button?.frame = CGRect(x: 180, y: 300, width: 140, height: 40)
        view.addSubview(view3Button!)
        view3Button?.addTarget(self, action: #selector(transformView3), for: .touchUpInside)
        
    }
    
    @objc private func rotateView1() {
        if view1Rotated {
            view1?.transform = .identity
        } else {
            view1?.transform = CGAffineTransform(rotationAngle: 45 * .pi/180)
        }
        view1Rotated = !view1Rotated
        print("view 1's frame: \(view1!.frame)")
        print("view 1's bound: \(view1!.bounds)")
        print("view 1's center: \(view1!.center)")
    }
    
    @objc private func transformView2() {
        if view2Transformed {
            view2?.transform = .identity
        } else {
//            let r = CGAffineTransform(rotationAngle: 45 * .pi/180)
            let t = CGAffineTransform(translationX:100, y:0)
            view2?.transform = t
        }
        view2Transformed = !view2Transformed
        print("view 2's frame: \(view2!.frame)")
        print("view 2's bound: \(view2!.bounds)")
        print("view 2's center: \(view2!.center)")
    }
    
    @objc private func transformView3() {
        if view3Transformed {
            view3?.transform = .identity
        } else {
            let r = CGAffineTransform(rotationAngle: 45 * .pi/180)
            let t = CGAffineTransform(translationX:100, y:0)
            view3?.transform = r.concatenating(t)
        }
        view3Transformed = !view3Transformed
        print("view 3's frame: \(view3!.frame)")
        print("view 3's bound: \(view3!.bounds)")
        print("view 3's center: \(view3!.center)")
    }
}
