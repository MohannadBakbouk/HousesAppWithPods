//
//  PhotoParams.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

struct PhotoParams {
    var page : Int
    var perPage : Int
    var query : String
    
    init(query : String = "House") {
        self.query = query
        self.page = 1
        self.perPage = 10
    }
    
    func toDictionary() -> [String : Any]{
        ["client_id" : PhotoAPI.key ,
         "query" : query,
         "page" : page,
         "per_page" : perPage]
    }
}



