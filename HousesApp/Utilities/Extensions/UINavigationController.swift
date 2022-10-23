//
//  UINavigationController.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import UIKit

extension UINavigationController{
    convenience init(hideBar : Bool){
        self.init()
        navigationBar.isHidden = hideBar
    }
}
