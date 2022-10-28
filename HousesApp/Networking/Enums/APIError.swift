//
//  APIError.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
enum APIError : Error {
    case server
    case parse
    case invalidUrl
    case internetOffline
    case errorOccured
    
    var message : String {
        switch self {
        case .internetOffline:
            return "Please make sure you are connected to the internet"
        case .server :
            return "an internal error occured in server side please try again later"
        case .errorOccured :
            return "Something went wrong"
        default:
            return "an internal error occured"
        }
    }
    
    static func convert(_ error : Error) -> APIError{
        print(error.localizedDescription)
        return error as? APIError ?? .errorOccured
    }
}
