//
//  PhotoQuery.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

// MARK: - PhotoQuery
struct PhotoQuery: Codable {
    let total, totalPages: Int
    let results: [PhotoQueryItem]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
