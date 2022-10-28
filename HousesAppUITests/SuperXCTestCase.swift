//
//  SuperXCTestCase.swift
//  HousesAppUITests
//
//  Created by Mohannad on 10/28/22.
//
import XCTest
import Swifter

enum APIPath {
   static let house = "houses"
   static let photos = "search/photos"
   static let actor0 = "characters/1880"
   static let actor1 = "characters/1881"
   static let actor2 = "characters/1882"
}

enum APIFileResponse {
    static let houses = "HousesResponse.json"
    static let photos = "HousePhotosResponse.json"
    static let actor0 = "Actor1880Response.json"
    static let actor1 = "Actor1881Response.json"
    static let actor2 = "Actor1882Response.json"
}



class SuperXCTestCase : XCTestCase {
    var app = XCUIApplication()
    let server = HttpServer()
    
    func initNormalServer(){
        do {
            let path = try TestUtil.path(for: APIFileResponse.houses, in: type(of: self))
            server[APIPath.house] = shareFile(path)
            let photosPaths = try TestUtil.path(for: APIFileResponse.photos, in: type(of: self))
            server[APIPath.photos] = shareFile(photosPaths)
            let actor1Path = try TestUtil.path(for: APIFileResponse.actor0, in: type(of: self))
            server[APIPath.actor0] = shareFile(actor1Path)
            let actor2Path = try TestUtil.path(for: APIFileResponse.actor1, in: type(of: self))
            server[APIPath.actor1] = shareFile(actor2Path)
            let actor3Path = try TestUtil.path(for: APIFileResponse.actor2, in: type(of: self))
            server[APIPath.actor2] = shareFile(actor3Path)
            try server.start()
        }
        catch{
            XCTAssert(false, "Swifter Server failed to start.")
        }
    }
    
    func initFailureServer(){
        do {
            server[APIPath.house] = { _ in
               return HttpResponse.internalServerError
            }
            try server.start()
        }
        catch{
            XCTAssert(false, "Swifter Server failed to start.")
        }
    }
}
