//
//  Source.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

// MARK: - Source
struct Source: Codable {
    let ancestry: Ancestry?
    let title, subtitle, sourceDescription, metaTitle: String?
    let metaDescription: String?
    let coverPhoto: CoverPhoto?

    enum CodingKeys: String, CodingKey {
        case ancestry, title, subtitle
        case sourceDescription = "description"
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case coverPhoto = "cover_photo"
    }
}
