//
//  ActorViewData.swift
//  HousesApp
//
//  Created by Mohannad on 10/24/22.
//
import Foundation

struct ActorViewData {
    var photo: PhotoViewData
    var name: String
    var gender: String
    var born: String
    var culture: String
}

extension ActorViewData {
    init(info : ActorQueryItem, photo: PhotoViewData) {
        self.name = info.name
        self.gender = info.gender
        self.culture = info.culture
        self.born = info.born
        self.photo = photo
    }
}
