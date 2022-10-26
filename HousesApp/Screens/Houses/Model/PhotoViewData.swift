//
//  PhotoViewData.swift
//  HousesApp
//
//  Created by Mohannad on 10/24/22.
//
import Foundation
struct PhotoViewData {
    var mainUrl : String
    var thumbUrl : String
}

extension PhotoViewData{
    init(with photo: PhotoQueryItem) {
        mainUrl = photo.urls.small
        thumbUrl = photo.urls.thumb
    }
}
