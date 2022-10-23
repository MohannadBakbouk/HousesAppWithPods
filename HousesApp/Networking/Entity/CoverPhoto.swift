//
//  CoverPhoto.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
// MARK: - CoverPhoto
struct CoverPhoto: Codable {
    let id: String
    let createdAt, updatedAt, promotedAt: String
    let width, height: Int
    let color, blurHash, coverPhotoDescription, altDescription: String
    let urls: Urls
    let links: ResultLinks
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [JSONAny]
    let sponsorship: JSONNull?
    let topicSubmissions: CoverPhotoTopicSubmissions
    let premium: Bool
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case coverPhotoDescription = "description"
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
        case topicSubmissions = "topic_submissions"
        case premium, user
    }
}

// MARK: - CoverPhotoTopicSubmissions
struct CoverPhotoTopicSubmissions: Codable {
}
