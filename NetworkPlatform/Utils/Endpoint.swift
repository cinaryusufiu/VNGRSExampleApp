//
//  Endpoint.swift
//  NetworkPlatform
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain

public enum Environment: String {
    case production
    case staging
    case dev

    public func getPath() -> String {
        switch self {
        case .production:
            return ""
        case .staging:
            return ""
        case .dev:
            return ""
        }
    }
}

public final class SettingsBundleHelper {
    static let shared = SettingsBundleHelper()
    
    private init() {}

    var currentEnvironment: Environment {
        return .dev
    }
}

enum ApiType: String {
    case none = "/v1/"
}

enum ServiceType {
    case none
}

final class Endpoint {

    typealias Parameters = [String: Any]
    typealias Path = String

    let method: HTTPMethod
    let path: Path
    let parameters: Parameters?
    let api: ApiType
    var queryItems: [URLQueryItem] = []

    init(method: HTTPMethod = .get,
         path: Path,
         parameters: Parameters? = [:],
         service: ServiceType = .none,
         api: ApiType = .none) {
             self.method = method
             self.path = path
             self.parameters = parameters
             self.api = api
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.pokemontcg.io"
        components.path = api.rawValue + path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    var headers: [String: Any] {
        return [ "Accept" : "application/json" ,
                 "Content-Type" : "application/json" ]
    }
}
