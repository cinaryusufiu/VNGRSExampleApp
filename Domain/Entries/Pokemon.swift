//
//  Pokemon.swift
//  Domain
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import SwiftyUserDefaults

public struct ResponseModel<T: Codable>: Codable {
    
    public var cards: T?
    
    public init(cards: T? = nil) {
        self.cards = cards
    }
}

public struct Pokemon: Codable, DefaultsSerializable , Equatable {
    public var id: String?
    public var name: String?
    public var imageUrl: String?
    public var isFav: Bool?
    
    public static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
       return lhs.id == rhs.id
    }
    
    public init(id: String? = nil, name: String? = nil, imageUrl: String? = nil) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
