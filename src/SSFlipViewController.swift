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

    public var frontVC: UIViewController!
    public var backVC: UIViewController!
    public var flipInterval: TimeInterval = 1.5
    private(set) var showingFront: Bool = true
    public var flipsOnTouch: Bool = true
    public var delegate: SSFlipViewControllerDelegate & UIViewController
    
    public init(front: UIViewController, back: UIViewController, delegate: SSFlipViewControllerDelegate & UIViewController) {
        self.frontVC = front
        self.backVC = back
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addChild(frontVC)
        addChild(backVC)
        view.addSubview(frontVC.view)
        frontVC.view.frame = view.frame
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {if flipsOnTouch {flip()}}
    
    @objc public func flip() {
        view.layer.flipAnimation(flipInterval)
        showingFront = !showingFront
        let _ = Timer.scheduledTimer(timeInterval: flipInterval/2.0, target: self, selector: #selector(swapViews), userInfo: nil, repeats: false)
        delegate.didFlip(flipVC: self)
    }
    @objc private func swapViews() {
        if showingFront {
            view.addSubview(frontVC.view)
            backVC.view.removeFromSuperview()
        } else {
            view.addSubview(backVC.view)
            frontVC.view.removeFromSuperview()
        }
    }
}
