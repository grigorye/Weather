//
//  CellTransitioningNavigationControllerDelegate.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 20/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UINavigationController

class CellTransitioningNavigationControllerDelegate : NSObject, UINavigationControllerDelegate {
    
    // MARK: - <UINavigationControllerDelegate>
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from: UIViewController, to: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            return pushAnimator
        case .pop:
            return popAnimator
        default:
            () // do nothing
            return nil
        }
    }
    
    // MARK: -
    
    lazy var pushAnimator = ExpandFromCellTransitioningAnimator(
        cellFrame: cellFrame
    )
    
    lazy var popAnimator = CollapseToCellTransitioningAnimator(
        cellFrame: cellFrame,
        upperPartSnapshotView: pushAnimator.upperPartSnapshotView,
        lowerPartSnapshotView: pushAnimator.lowerPartSnapshotView,
        completionHandler: popCompletionHandler
    )
    
    let cellFrame: CGRect
    let popCompletionHandler: () -> Void
    
    init(cellFrame: CGRect, popCompletionHandler: @escaping () -> Void) {
        
        self.cellFrame = cellFrame
        self.popCompletionHandler = popCompletionHandler
    }
    
    deinit {()}
}
