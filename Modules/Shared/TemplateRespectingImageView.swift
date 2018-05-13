//
//  TemplateRespectingImageView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

/// https://stackoverflow.com/a/40938514/1859783
class TemplateRespectingImageView : UIImageView {
    
    override func didMoveToSuperview() {
        
        isHighlighted = !isHighlighted
        isHighlighted = !isHighlighted
        
        super.didMoveToSuperview()
    }
}
