//
//  HTTPMethod.swift
//  NetworkPlatform
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    
    public static let get = HTTPMethod(rawValue: "GET")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    public static let post = HTTPMethod(rawValue: "POST")
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
