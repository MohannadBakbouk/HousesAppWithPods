//
//  BasePhotoCell.swift
//  HousesApp
//
//  Created by Mohannad on 10/24/22.
//
import Foundation
import UIKit
import SnapKit
import Kingfisher

class BasePhotoCell: UICollectionViewCell {
    var photoView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.kf.indicatorType = .activity
        img.isSkeletonable = true
        return img
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setupViews(){
        setupContentView()
        contentView.addSubview(photoView)
        setupViewsConstraints()
    }
    
    func setupContentView(){
        isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.layer.cornerRadius = 8.0
        contentView.clipsToBounds = true
    }
    
    func setupViewsConstraints(){
        photoView.snp.makeConstraints {$0.top.leading.trailing.bottom.equalTo(contentView)}
    }
}
