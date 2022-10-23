//
//  ResultLinks.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

// MARK: - ResultLinks
struct ResultLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}
