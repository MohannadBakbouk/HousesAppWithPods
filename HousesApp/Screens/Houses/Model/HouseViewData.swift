//
//  HouseViewData.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

struct HouseViewData {
    var photoUrl : String
    var name : String
    var region : String
}

extension HouseViewData {
    
    init(info : HouseQueryItem , photo : PhotoQueryItem) {
        self.name = info.name
        self.region = info.region
        self.photoUrl = photo.urls.small
    }
}
