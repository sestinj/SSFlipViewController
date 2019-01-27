//
//  CALayer.swift
//  Taco Tapper
//This is a cal
//  Created by Nate Sesti on 6/22/18.
//  Copyright © 2018 Nate Sesti. All rights reserved.
//

import Foundation
import UIKit

fileprivate var flipAxis: SSFlipViewController.Axis = .y
fileprivate var flipInterval: TimeInterval!
fileprivate var flipAngle: CGFloat!
extension CALayer {
    fileprivate func animate(_ keyPath: String, from: Any, duration: Double) {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = from
        animation.toValue = self.value(forKey: keyPath)
        animation.duration = duration
        animation.autoreverses = false
        self.add(animation, forKey: keyPath)
    }
    
    func flipAnimation(_ timeInterval: TimeInterval, axis: SSFlipViewController.Axis, angle: CGFloat) {
        let temp = transform
        flipAxis = axis
        flipAngle = angle
        flipInterval = timeInterval
        switch axis {
        case .x:
            transform = CATransform3DRotate(transform, angle/2.0, 1.0, 0.0, 0.0)
        case .y:
            transform = CATransform3DRotate(transform, angle/2.0, 0.0, 1.0, 0.0)
        case .z:
            transform = CATransform3DRotate(transform, angle/2.0, 0.0, 0.0, 1.0)
        case .xy:
            transform = CATransform3DRotate(transform, angle/2.0, 1.0, 1.0, 0.0)
        case .xyz:
            transform = CATransform3DRotate(transform, angle, 1.0, 1.0, 1.0)
        case .yz:
            transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 1.0)
        case .xz:
            transform = CATransform3DRotate(transform, angle, 1.0, 0.0, 1.0)
        }
        animate(#keyPath(CALayer.transform), from: temp, duration: timeInterval/2.0)
        //For some animations, the matrix is the same at the end as in the beginning, so it must be cut in half to show a transition, hence the below timer.
        let _ = Timer.scheduledTimer(timeInterval: timeInterval/2.0, target: self, selector: #selector(flipAnimationSecondHalf), userInfo: nil, repeats: false)
    }
    @objc private func flipAnimationSecondHalf() {
        let temp = transform
        switch flipAxis {
        case .x:
            transform = CATransform3DRotate(transform, flipAngle/2.0, 1.0, 0.0, 0.0)
        case .y:
            transform = CATransform3DRotate(transform, flipAngle/2.0, 0.0, 1.0, 0.0)
        case .z:
            transform = CATransform3DRotate(transform, flipAngle/2.0, 0.0, 0.0, 1.0)
        case .xy:
            transform = CATransform3DRotate(transform, flipAngle/2.0, 1.0, 1.0, 0.0)
        case .xyz:
            transform = CATransform3DRotate(transform, flipAngle, 1.0, 1.0, 1.0)
        case .yz:
            transform = CATransform3DRotate(transform, flipAngle, 0.0, 1.0, 1.0)
        case .xz:
            transform = CATransform3DRotate(transform, flipAngle, 1.0, 0.0, 1.0)
        }
        animate(#keyPath(CALayer.transform), from: temp, duration: flipInterval/2.0)
    }
}
