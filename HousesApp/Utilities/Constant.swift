//
//  Constant.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Foundation
enum MainAPI {
    static var url = "https://anapioficeandfire.com/api/"
    static let localUrl = "http://localhost:8080"
    static let key = ""
    static let content = "application/json; charset=utf-8"
}

enum PhotoAPI {
    static var url = "https://api.unsplash.com/"
    static let key = "qSz_rhiBdd0roXBBvK_7nk5uxWEJmyQfSq4-gWjldrg"
    static let content = "application/json; charset=utf-8"
}

enum Images {
    static let exclamationmark = "exclamationmark.circle.fill"
    static let mapPin = "mappin.and.ellipse"
    static let leftArrow = "left_arrow"
    static let circle = "dot.circle.fill"
}

enum Messages {
    static let noResults = "There are no data to display"
    static let noTitle = "Default Title"
}
