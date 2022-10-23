//
//  ColorOfWater.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
// MARK: - ColorOfWater
struct ColorOfWater: Codable {
    let status: String
    let approvedOn: String

    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}
