//
//  HouseQueryItem.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

// MARK: - HouseQueryItem
struct HouseQueryItem: Codable {
    let url: String
    let name, region, coatOfArms, words: String
    let titles, seats: [String]
    let currentLord, heir, overlord: String
    let founded: Founded
    let founder: String
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches, swornMembers: [String]
}

enum Founded: String, Codable {
    case comingOfTheAndals = "Coming of the Andals"
    case empty = ""
    case the299AC = "299 AC"
}
