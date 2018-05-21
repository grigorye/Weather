//
//  CollapseToCellTransitioningAnimator.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 20/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class CollapseToCellTransitioningAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - <UIViewControllerAnimatedTransitioning>
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let upperPartSnapshotView = self.upperPartSnapshotView
        let lowerPartSnapshotView = self.lowerPartSnapshotView
        
        let upperPartInitialFrame = upperPartSnapshotView.frame
        let lowerPartInitialFrame = lowerPartSnapshotView.frame
        
        let finalToFrame = transitionContext.finalToFrame

        let framesMatchPushedOnes = (finalToFrame.height == (upperPartInitialFrame.height + lowerPartInitialFrame.height)) && (finalToFrame.width == upperPartInitialFrame.width)
        
        guard framesMatchPushedOnes else {
            animateNoCollapseTransition(using: transitionContext)
            return
        }
        
        func frameFromInitialAdjustedForFinal(_ frame: CGRect) -> CGRect {
            return frame.with {
                $0.origin.y -= transitionContext.initialFromFrame.origin.y
                $0.origin.y += finalToFrame.origin.y
            }
        }
        
        let upperPartFinalFrame = frameFromInitialAdjustedForFinal(upperPartInitialFrame).with {
            $0.origin.y += upperPartInitialFrame.height
        }
        let lowerPartFinalFrame = frameFromInitialAdjustedForFinal(lowerPartInitialFrame).with {
            $0.origin.y -= lowerPartInitialFrame.height
        }
        
        let containerView = transitionContext.containerView

        ///

        assert(toView.alpha.isZero)

        containerView.addSubview(upperPartSnapshotView)
        containerView.addSubview(lowerPartSnapshotView)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [slideIn] in
            
            upperPartSnapshotView.frame = upperPartFinalFrame
            lowerPartSnapshotView.frame = lowerPartFinalFrame
            
            if slideIn {
                fromView.frame.origin.y = self.cellFrame.origin.y
            }
            
            fromView.alpha = collapsedCellBackgroundAlpha
            
        }, completion: { (finish) in
            
            upperPartSnapshotView.removeFromSuperview()
            lowerPartSnapshotView.removeFromSuperview()
            
            containerView.addSubview(toView)
            toView.frame = finalToFrame
            toView.alpha = 1
            
            transitionContext.completeTransition(true)
            self.completionHandler()
        })
    }
    
    func animateNoCollapseTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        let containerView = transitionContext.containerView

        containerView.addSubview(toView)
        toView.frame = transitionContext.finalToFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            fromView.alpha = collapsedCellBackgroundAlpha
            toView.alpha = 1
            
        }, completion: { (finish) in
            
            transitionContext.completeTransition(true)
        })
        
    }
    
    // MARK: -
    
    let cellFrame: CGRect
    let upperPartSnapshotView: UIImageView
    let lowerPartSnapshotView: UIImageView
    let slideIn: Bool
    let completionHandler: () -> Void
    
    init(cellFrame: CGRect, slideIn: Bool = false, upperPartSnapshotView: UIImageView, lowerPartSnapshotView: UIImageView, completionHandler: @escaping () -> Void = {}) {
        
        self.cellFrame = cellFrame
        self.slideIn = slideIn
        self.upperPartSnapshotView = upperPartSnapshotView
        self.lowerPartSnapshotView = lowerPartSnapshotView
        self.completionHandler = completionHandler
    }
    
    deinit {()}
}
