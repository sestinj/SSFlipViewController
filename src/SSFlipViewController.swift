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

public class SSFlipViewController: UIViewController {
    ///The front view controller.
    public var frontVC: UIViewController!
    ///The back view controller.
    public var backVC: UIViewController!
    ///The number of seconds taken to execute the flip.
    public var flipInterval: TimeInterval = 1.5
    ///This should be self explanatory.
    private(set) var showingFront: Bool = true
    ///When set to true, any touch on the view will cause a flip. Set to false to make your own controls.
    public var flipsOnTouch: Bool = true
    ///The delegate is notified when a flip occurs. It is not necessary to set.
    public var delegate: (SSFlipViewControllerDelegate & UIViewController)?
    ///The axis about which the rotation occurs.
    public var flipAxis: Axis = .y
    private var isFlipping = false
    
    public enum Axis {
        case x, y, z, xy, xz, yz, xyz
    }
    
    public init(front: UIViewController, back: UIViewController) {
        self.frontVC = front
        self.backVC = back
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(frontVC.view)
        view.addSubview(backVC.view)
        addChild(frontVC)
        addChild(backVC)
        frontVC.view.frame.size = view.frame.size
        backVC.view.frame.size = view.frame.size
        backVC.view.layer.opacity = 0.0
        backVC.view.layer.flipAnimation(0.0, axis: flipAxis, angle: CGFloat.pi)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {if flipsOnTouch {flip()}}
    
    ///Animates the flipping of the view controller
    @objc public func flip() {
        guard !isFlipping else {return}
        view.layer.flipAnimation(flipInterval, axis: flipAxis, angle: CGFloat.pi)
        showingFront = !showingFront
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
    @objc private func flipOpacity() {
        if showingFront {
            frontVC.view.layer.opacity = 1.0
            backVC.view.layer.opacity = 0.0
        } else {
            frontVC.view.layer.opacity = 0.0
            backVC.view.layer.opacity = 1.0
        }
    }
}
