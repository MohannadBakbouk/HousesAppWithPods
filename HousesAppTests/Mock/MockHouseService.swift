//
//  MockHouseService.swift
//  HousesAppTests
//
//  Created by Mohannad on 10/26/22.
//
import Foundation
import Combine
@testable import HousesApp

final class MockHouseService : HouseServiceProtocol{
    func fetchHouses() -> AnyPublisher<[HouseQueryItem], APIError> {
        let data = try? Data(contentsOf: Bundle.main.url(forResource: "HousesResponse", withExtension: "json")!)
        let response = try! JSONDecoder().decode([HouseQueryItem].self, from: data!)
        let stream : AnyPublisher<[HouseQueryItem], APIError> = Result.Publisher(response).eraseToAnyPublisher()
        return stream
    }
}

extension MockHouseService{
    class func fetchFormatedHouse() -> HouseViewData{
        let data = try? Data(contentsOf: Bundle.main.url(forResource: "HousesResponse", withExtension: "json")!)
        var houses = try! JSONDecoder().decode([HouseQueryItem].self, from: data!)
        houses.sort{$0.swornMembers.count > $1.swornMembers.count}
        let photodata = try? Data(contentsOf: Bundle.main.url(forResource: "HousePhotosResponse", withExtension: "json")!)
        let photos = try! JSONDecoder().decode(PhotoQuery.self, from: photodata!)
        var info = HouseViewData(info: houses.first!, photo: photos.results.first!)
        info.actors = ["1880", "1881","1882"]
        return info
    }
}
