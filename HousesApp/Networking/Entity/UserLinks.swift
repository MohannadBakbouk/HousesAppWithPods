//
//  UserLinks.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Foundation
// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}
