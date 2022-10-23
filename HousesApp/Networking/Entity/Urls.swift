//
//  Urls.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
