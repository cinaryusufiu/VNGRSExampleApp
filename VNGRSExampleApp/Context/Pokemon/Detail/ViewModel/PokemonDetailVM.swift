//
//  PokemonDetailVM.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain
import Combine
import CachePlatform

final class PokemonDetailVM: VGBaseVM {
    
    // MARK: - TypeAlias
    
    // MARK: - Properties
    
    private(set) var model: Domain.Pokemon
    private let usecase: Domain.PokemonUseCase
    private var subscriptions = Set<AnyCancellable>()
    
    init(model: Pokemon) {
        self.model = model
        self.usecase = CachePlatform.PokemonUseCaseProvider().makePokemonUseCase()
    }
    
    // MARK: - Public Functions
    
    func savePokemon() {
        self.state?(.loading(false))
        usecase.checkFav(item: model).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure:
                    self.state?(.failure(StateErrorType.notFound.getValue()))
                case .finished:
                    self.state?(.completed)
                    break
                }
            }) { [weak self] response in
                if let model = response.cards {
                    self?.model = model
                }
                self?.state?(.success)
            }
        .store(in: &subscriptions)
    }
    
    func fetchPokemons() {
        self.state?(.loading(false))
        usecase.fetchAllPokemons(searchText: "").receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure:
                    self.state?(.failure(StateErrorType.unknown.getValue()))
                case .finished:
                    break
                }
            }) { [weak self] responseModel in
                guard let self = self else { return }
                guard responseModel.cards?.count ?? 0 > 0 else {
                    self.state?(.failure(StateErrorType.parserNotWork.getValue()))
                    return
                }
                let newArray = responseModel.cards?.filter({ $0.id == self.model.id })
                if let isEmpty = newArray?.isEmpty {
                    self.model.isFav = !isEmpty
                }
                self.state?(.success)
        }.store(in: &subscriptions)
    }
}
