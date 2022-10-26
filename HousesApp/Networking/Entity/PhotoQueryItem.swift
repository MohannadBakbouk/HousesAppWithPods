//
//  PhotoQueryItem.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
// MARK: - PhotoQueryItem
struct PhotoQueryItem: Codable {
    let id: String
    let createdAt, updatedAt: String
    let promotedAt: String?
    let width, height: Int
    let color, blurHash: String?
    let resultDescription: String?
    let altDescription: String?
    let urls: Urls
    let links: ResultLinks
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [JSONAny]
    let topicSubmissions: ResultTopicSubmissions
    let user: User?
    let tags: [Tag]?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case resultDescription = "description"
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case topicSubmissions = "topic_submissions"
        case user, tags
    }
}
