//
//  PopUpType.swift
//  Domain
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation

public enum PopUpType: String, Codable {
    case success
    case error
    case info
    case warning
    case none
}

public struct PopUpModel: Codable {
    public var title: String?
    public var message: String?
    public var type: PopUpType?
    
    public init(title: String? = nil, message: String? = nil, type: PopUpType? = nil) {
        self.title = title
        self.message = message
        self.type = type
    }
}
