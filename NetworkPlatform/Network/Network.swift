//
//  Network.swift
//  NetworkPlatform
//
//  Created by Yusuf Çınar on 16.08.2023.
//
//

import Foundation
import Combine
import Domain

final class Network {

    init() { }
    
    func request<T>(type: T.Type, endPoint: Endpoint) -> AnyPublisher<T, Error> where T : Codable {
        
        var urlRequest = URLRequest(url: endPoint.url)
        
        urlRequest.httpMethod = endPoint.method.rawValue
        
        endPoint.headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        if endPoint.method == .post {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: endPoint.parameters ?? [:])
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
