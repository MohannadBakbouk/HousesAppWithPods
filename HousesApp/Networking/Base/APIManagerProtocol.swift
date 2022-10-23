//
//  APIManagerProtocol.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Foundation
import Combine

public typealias JSON = [String : Any]

protocol  APIManagerProtocol {
    func request<T: Codable>(endpoint: EndPoint , method: Method , params: JSON?) -> AnyPublisher<T, APIError>
    func call<T: Codable>(request: URLRequest) -> AnyPublisher<T, APIError>
}
