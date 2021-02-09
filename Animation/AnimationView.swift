//
//  AnimationView.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/2/6.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import UIKit

class AnimationView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)
        print("hit test point: \(point)")
        print("hit test result: \(result)")
        return result
    }

}
