//
//  UIStackView+ContainerViewController.swift.swift
//  GEUIKit
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

//
// Based on:
// https://useyourloaf.com/blog/container-view-controllers/
// https://github.com/kharrison/CodeExamples/tree/master/Container/Container-code
//

extension UIViewController {
    
    func addChildViewController(_ child: UIViewController, to stackView: UIStackView) {
        
        addChildViewController(child)
        stackView.addArrangedSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func removeChildViewController(_ child: UIViewController, from subview: UIStackView) {
        
        child.willMove(toParentViewController: nil)
        child.view.removeFromSuperview()
        child.removeFromParentViewController()
    }
}
