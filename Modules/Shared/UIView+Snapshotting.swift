//
//  UIView+Snapshotting.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 20/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

extension UIView {
    
    func snapshotWithImageContext() -> UIImage {
        
        let boundsSize = bounds.size
        
        UIGraphicsBeginImageContextWithOptions(boundsSize, true, 0)
        defer { UIGraphicsEndImageContext() }
        
        let succeeded = drawHierarchy(in: CGRect(origin: .zero, size: boundsSize), afterScreenUpdates: false)
        assert(succeeded)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    func snapshotWithRenderer() -> UIImage {
        
        let boundsSize = bounds.size
        
        let renderer = UIGraphicsImageRenderer(size: boundsSize)
        let image = renderer.image { (ctx) in
            drawHierarchy(in: CGRect(origin: .zero, size: boundsSize), afterScreenUpdates: false)
        }
        return image
    }
    
    func snapshot() -> UIImage {
        return snapshotWithRenderer()
    }
}
