//
//  ExpandFromCellTransitioningAnimator.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 20/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

let collapsedCellBackgroundAlpha: CGFloat = 0.65

class ExpandFromCellTransitioningAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - <UIViewControllerAnimatedTransitioning>
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        // Create two image views with snapshots of sliding parts of the source view
        let snapshot = fromView.snapshot()
        let snapshotFrame = CGRect(origin: .zero, size: snapshot.size)
        let (upperPartFrame, lowerPartFrame) = snapshotFrame.divided(atDistance: cellFrame.maxY, from: .minYEdge)
        let upperPartSnapshot = snapshot.cropping(to: upperPartFrame)
        let lowerPartSnapshot = snapshot.cropping(to: lowerPartFrame)
        let upperPartSnapshotView = UIImageView(image: upperPartSnapshot).then {
            $0.frame = upperPartFrame
        }
        let lowerPartSnapshotView = UIImageView(image: lowerPartSnapshot).then {
            $0.frame = lowerPartFrame
        }
        
        [upperPartSnapshotView, lowerPartSnapshotView].forEach {
            let initialFromFrame = transitionContext.initialFromFrame
            $0.frame.origin.y += initialFromFrame.origin.y
        }
        
        let upperPartEndFrame = upperPartFrame.offsetBy(dx: 0, dy: -upperPartFrame.height)
        let lowerPartEndFrame = lowerPartFrame.offsetBy(dx: 0, dy: lowerPartFrame.height)
        
        let finalToFrame = transitionContext.finalToFrame

        let containerView = transitionContext.containerView
        
        ///
        
        fromView.alpha = 0 // replaced with snapshots right away
        toView.alpha = collapsedCellBackgroundAlpha
        toView.frame = finalToFrame.with {
            if slideIn {
                $0.origin.y = cellFrame.origin.y
            }
        }
        
        containerView.addSubview(toView)
        containerView.addSubview(upperPartSnapshotView)
        containerView.addSubview(lowerPartSnapshotView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            upperPartSnapshotView.frame = upperPartEndFrame
            lowerPartSnapshotView.frame = lowerPartEndFrame
            
            toView.frame = finalToFrame
            toView.alpha = 1
            
        }, completion: { (finish) in
            
            self.upperPartSnapshotView = upperPartSnapshotView
            self.lowerPartSnapshotView = lowerPartSnapshotView
            
            upperPartSnapshotView.removeFromSuperview()
            lowerPartSnapshotView.removeFromSuperview()
            
            transitionContext.completeTransition(true)
        })
    }
    
    // MARK: -
    
    let cellFrame: CGRect
    
    private(set) var upperPartSnapshotView: UIImageView!
    private(set) var lowerPartSnapshotView: UIImageView!
    
    let slideIn: Bool

    init(cellFrame: CGRect, slideIn: Bool = false) {
        
        self.cellFrame = cellFrame
        self.slideIn = slideIn
    }
    
    deinit {()}
}
