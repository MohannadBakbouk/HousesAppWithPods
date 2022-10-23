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
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize = CGSize(width: 0, height: 5) , radius: CGFloat = 7, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
    func corners(with value : UIRectCorner = .allCorners , radius : Double){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: value, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

