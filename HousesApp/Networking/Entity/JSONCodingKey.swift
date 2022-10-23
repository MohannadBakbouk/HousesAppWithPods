//
//  JSONCodingKey.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

