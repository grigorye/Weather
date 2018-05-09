//
//  KeyboardAwareViewController.swift
//  GEUIKit
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit
import LHSKeyboardAdjusting

class KeyboardAwareViewController: UIViewController, LHSKeyboardAdjusting {
    
    var keyboardAdjustingBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var keyboardAdjustedView: UIView!
    
    func keyboardAdjustingView() -> UIView! {
        return keyboardAdjustedView
    }
    
    func keyboardAdjustingAnimated() -> Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lhs_activateKeyboardAdjustment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        lhs_deactivateKeyboardAdjustment()
    }
}
