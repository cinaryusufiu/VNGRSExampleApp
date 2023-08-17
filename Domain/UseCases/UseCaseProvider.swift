//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation

public protocol PokemonUseCaseProvider {
    
    func makePokemonUseCase() -> PokemonUseCase
}
