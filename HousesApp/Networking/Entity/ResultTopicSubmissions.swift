//
//  ResultTopicSubmissions.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
// MARK: - ResultTopicSubmissions
struct ResultTopicSubmissions: Codable {
    let colorOfWater: ColorOfWater?

    enum CodingKeys: String, CodingKey {
        case colorOfWater = "color-of-water"
    }
}
