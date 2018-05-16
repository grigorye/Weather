//
//  BundledImageLiterals.swift
//  WeatherApp
//
//  Created by Grigory Entin on 16/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

/// Exploiting the idea about supporting image literals in frameworks: https://stackoverflow.com/a/46292441/1859783

struct BundledImage: _ExpressibleByImageLiteral {
    
    let image: UIImage
    
    init(imageLiteralResourceName name: String) {
        
        self.image = UIImage(named: name, in: Bundle.current, compatibleWith: nil)!
    }
}

extension UIImage {
    
    static func bundled(_ bundledImage: BundledImage) -> UIImage {
        return bundledImage.image
    }
}
