//
//  ActorQueryItem.swift
//  HousesApp
//
//  Created by Mohannad on 10/24/22.
//
import Foundation

// MARK: - ActorQueryItem
struct ActorQueryItem: Codable {
    let url: String
    let name, gender, culture, born: String
    let died: String
    let titles, aliases: [String]
    let father, mother, spouse: String
    let allegiances, books, povBooks: [String]
    let tvSeries, playedBy: [String]
}
