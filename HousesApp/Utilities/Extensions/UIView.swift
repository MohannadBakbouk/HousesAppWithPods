//
//  UIView.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import UIKit

extension UIView {
    func addSubviews(contentOf items: [UIView]){
        _ = items.map{addSubview($0)}
    }
}

