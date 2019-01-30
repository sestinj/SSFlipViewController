//
//  SSFlipViewController.swift
//  Pods-SSFlipViewController_Example
//
//  Created by Nate Sesti on 1/24/19.
//

import UIKit

public protocol SSFlipViewControllerDelegate {
    func didFlip(flipVC: SSFlipViewController)
}

open class SSFlipViewController: UIViewController {
    ///The view controllers (faces)
    public var viewControllers: [UIViewController]
    ///The number of seconds taken to execute the flip.
    public var flipInterval: TimeInterval = 1.5
    ///Which view controller is currently facing frontward (0 indexing)
    public var visibleFace: Int = 0
    ///When set to true, any touch on the view will cause a flip. Set to false to make your own controls.
    public var flipsOnTouch: Bool = true
    ///The delegate is notified when a flip occurs. It is not necessary to set.
    public var delegate: (SSFlipViewControllerDelegate & UIViewController)?
    ///The axis about which the rotation occurs. *IMPORTANT: If you are setting this property, do so before the view is loaded or added as a subview, or else some views will be backwards.
    public var flipAxis: Axis = .y
    private var isFlipping = false
    
    public enum Axis {
        case x, y, z, xy, xz, yz, xyz
    }
    
    public init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
        for vc in viewControllers {
            view.addSubview(vc.view)
            addChild(vc)
            vc.view.frame.size = view.frame.size
        }
        preFlip(all: false)
        flipOpacity()
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {if flipsOnTouch {flip()}}
    
    ///Flips vcs of odd indices so they aren't backwards/upside down when flipped to
    private func preFlip(all: Bool) {
        if flipAxis == .xz || flipAxis == .yz || flipAxis == .xyz {
            return
        }
        for i in 0..<viewControllers.count {
            let vc = viewControllers[i]
            if all && viewControllers.count % 2 == 0 {return}
            if !(i % 2 == 0) || all {
                vc.view.layer.flipAnimation(0.0, axis: flipAxis, angle: CGFloat.pi)
            }
        }
    }
    
    ///Animates the flipping of the view controller
    @objc public func flip() {
        guard !isFlipping else {return}
        view.layer.flipAnimation(flipInterval, axis: flipAxis, angle: CGFloat.pi)
        visibleFace += 1
        if visibleFace >= viewControllers.count {
            visibleFace = 0
            shouldPreFlip = true
        }
        if let delegate = delegate {
            delegate.didFlip(flipVC: self)
        }
        let _ = Timer.scheduledTimer(timeInterval: flipInterval/2.0, target: self, selector: #selector(flipOpacity), userInfo: nil, repeats: false)
        isFlipping = true
        let _ = Timer.scheduledTimer(timeInterval: flipInterval, target: self, selector: #selector(notFlipping), userInfo: nil, repeats: false)
    }
    @objc private func notFlipping() {
        isFlipping = false
    }
    
    private var shouldPreFlip: Bool = false
    @objc private func flipOpacity() {
        if shouldPreFlip {
            shouldPreFlip = false
            preFlip(all: true)
        }
        for i in 0..<viewControllers.count {
            let vc = viewControllers[i]
            if i == visibleFace {
                vc.view.layer.opacity = 1.0
            } else {
                vc.view.layer.opacity = 0.0
            }
        }
    }
}
