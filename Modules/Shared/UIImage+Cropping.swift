//
//  UIImage+Cropping.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 20/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit
import Then

// https://stackoverflow.com/q/158914/1859783

extension CGRect {
    
    func scaled(_ scale: CGFloat) -> CGRect {
        
        return self.with {
            $0.origin.x *= scale
            $0.origin.y *= scale
            $0.size.width *= scale
            $0.size.height *= scale
        }
    }
}

extension UIImage {
    
    func cropping(to rect: CGRect) -> UIImage {
        
        let scaledRect = rect.scaled(scale)
        let cgImage = self.cgImage!
        let croppedCGImage = cgImage.cropping(to: scaledRect)!
        let croppedImage = UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
        return croppedImage
    }
}
