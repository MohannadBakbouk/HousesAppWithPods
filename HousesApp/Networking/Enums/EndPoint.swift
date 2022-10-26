//
//  EndPoint.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

enum EndPoint  {
    case houses
    case photos
    case actor(id : Int)
    
    var path : String {
        switch self {
            case .houses: return "\(MainAPI.url)/houses"
            case .actor(let id): return "\(MainAPI.url)/characters/\(id)"
            case .photos:  return "\(PhotoAPI.url)/search/photos"
      }
    }
}
