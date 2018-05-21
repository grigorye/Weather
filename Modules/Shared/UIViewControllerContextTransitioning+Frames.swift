//
//  UIViewControllerContextTransitioning+Frames.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 21/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

extension UIViewControllerContextTransitioning {
    
    var finalToFrame: CGRect {
        let toViewController = self.viewController(forKey: .to)!
        let finalToFrame = self.finalFrame(for: toViewController)
        return finalToFrame
    }
    
    var initialFromFrame: CGRect {
        let fromViewController = self.viewController(forKey: .from)!
        let initialFromFrame = self.initialFrame(for: fromViewController)
        return initialFromFrame
    }
}
