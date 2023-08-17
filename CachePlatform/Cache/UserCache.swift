//
//  UserCache.swift
//  CachePlatform
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import Foundation
import Domain
import SwiftyUserDefaults

final class UserCache { init() { } }

extension DefaultsKeys {
    var pokemons: DefaultsKey<[Pokemon]?> { .init("favModels" , defaultValue: nil) }
}
