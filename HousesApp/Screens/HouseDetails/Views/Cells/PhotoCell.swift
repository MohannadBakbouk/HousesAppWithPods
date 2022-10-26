//
//  PhotoCell.swift
//  HousesApp
//
//  Created by Mohannad on 10/24/22.
//
import Foundation

final class PhotoCell: BasePhotoCell{
    override var isSelected: Bool{
        didSet{
            contentView.border(isSelected ? 3.5 : 0.0)
        }
    }
    
    func configure(with model : PhotoViewData){
        guard let url = URL(string: model.thumbUrl) else { return}
        photoView.kf.setImage(with: url)
    }
}
