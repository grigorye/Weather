//
//  Bundle.swift
//  GEBase
//
//  Created by Grigory Entin on 06/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// Returns bundle for the current module.
    internal static var current : Bundle {
        class Tag {}
        return Bundle(for: Tag.self)
    }
}
