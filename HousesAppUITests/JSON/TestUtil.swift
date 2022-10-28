//
//  TestHelper.swift
//  HousesAppUITests
//
//  Created by Mohannad on 10/27/22.
//
import Foundation
import XCTest

enum TestUtilError: Error {
    case fileNotFound
}

class TestUtil {
    static func path(for fileName: String, in bundleClass: AnyClass) throws -> String {
        if let path = Bundle(for: bundleClass).path(forResource: fileName, ofType: nil) {
            return path
        } else {
            throw TestUtilError.fileNotFound
        }
    }
}

