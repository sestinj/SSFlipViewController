//
//  CALayer.swift
//  Taco Tapper
//This is a cal
//  Created by Nate Sesti on 6/22/18.
//  Copyright © 2018 Nate Sesti. All rights reserved.
//

import Foundation
import UIKit


fileprivate var isFlipping = false
extension CALayer {
    func animate(_ keyPath: String, from: Any, duration: Double) {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = from
        animation.toValue = self.value(forKey: keyPath)
        animation.duration = duration
        animation.autoreverses = false
        self.add(animation, forKey: keyPath)
    }
    
    
    func flipAnimation(_ timeInterval: TimeInterval) {
        guard !isFlipping else {return}
        let temp = transform
        transform = CATransform3DRotate(transform, CGFloat.pi, 0.0, 1.0, 0.0)
        animate(#keyPath(CALayer.transform), from: temp, duration: timeInterval)
        
        
//        let _ = Timer.scheduledTimer(timeInterval: timeInterval/2.0, target: self, selector: #selector(flipAllContents), userInfo: nil, repeats: false)
    }
    
    @objc func flipAllContents() {
        if let subs = sublayers {
            for sub in subs {
                sub.transform = CATransform3DRotate(sub.transform, CGFloat.pi, 0.0, 1.0, 0.0)
            }
        }
    }
}
