//
//  HouseViewData.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

struct HouseViewData {
    var photo : PhotoViewData
    var name : String
    var region : String
    var arms : String
    var titles : [String]
    var actors : [String]
    var id : String
}

extension HouseViewData {
    init(info : HouseQueryItem , photo : PhotoQueryItem) {
        self.name = info.name
        self.region = info.region
        self.arms = info.coatOfArms
        self.titles = info.titles
        self.actors = info.swornMembers.map{String($0.split(separator: Character("/")).last ?? "")}
        self.id = String(info.url.split(separator: Character("/")).last ?? "-1")
        self.photo = PhotoViewData(with: photo)
    }
}
