//
//  UIStackView.swift
//  HousesApp
//
//  Created by Mohannad on 10/29/22.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(contentOf items : [UIView]){
        _ = items.map{addArrangedSubview($0)}
    }
}
