//
//  APIManager.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Foundation
import Combine

final class APIManager: APIManagerProtocol {
    
    func request<T : Codable>(endpoint: EndPoint, method: Method, params: JSON?) -> AnyPublisher<T , APIError> {
        guard var urlComp = URLComponents(string: endpoint.path) else {
            return AnyPublisher(Fail<T, APIError>(error: APIError.invalidUrl))
        }
        /* I wont discuss all requests types  */
        if let body = params , method == .Get {
            urlComp.queryItems = []
            for item in body {
                let value = String(describing: item.value)
                urlComp.queryItems!.append(URLQueryItem(name: item.key, value: value))
            }
        }
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = method.rawValue
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return call(request: request)
    }
    
    func call<T>(request: URLRequest) -> AnyPublisher<T , APIError>  where T : Decodable, T : Encodable {
        return URLSession.shared
        .dataTaskPublisher(for: request)
        .tryMap{ output in
            guard  (output.response as? HTTPURLResponse)?.statusCode == 200  else {throw APIError.server}
            return output.data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError{APIError.convert($0)}
        .eraseToAnyPublisher()
    }
}
