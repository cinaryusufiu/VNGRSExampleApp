//
//  SearchPokemonVM.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain
import Combine

final class SearchPokemonVM: VGBaseVM {
  
    // MARK: - Properties
    
    private(set) var pokemons: [PokemonDetailVM] = []
    private let usecase: Domain.PokemonUseCase
    private var operationQueue: OperationQueue = OperationQueue()
    private var subscriptions = Set<AnyCancellable>()
    private var term: String = ""
    
    override var constant: VGBaseVMConstant {
        return VGBaseVMConstant(screenName: "SearchPage")
    }
    
    init(pokemons: [PokemonDetailVM], usecase: Domain.PokemonUseCase) {
        self.pokemons = pokemons
        self.usecase = usecase
    }
    
    // MARK: - Public Functions
    
    func remoaveAllItems(){
        self.pokemons.removeAll()
    }
    
    func textDidChange(searchText: String){
        self.term = searchText
        operationQueue.cancelAllOperations()
        createBlockOperation()
    }
    
    func itemVM(index: Int) -> PokemonDetailVM? {
        if pokemons.indices.contains(index)  {
            return pokemons[index]
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return pokemons.count
    }
    
    // MARK: - Private Functions
    
    private func startSearch() {
        guard term.count >= 3 else { return }
        self.state?(.loading(true))
        usecase.fetchAllPokemons(searchText: term).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure:
                    self.state?(.failure(StateErrorType.unknown.getValue()))
                case .finished:
                    break
                }
            }) { responseModel in
                guard responseModel.cards?.count ?? 0 > 0 else {
                    self.state?(.failure(StateErrorType.parserNotWork.getValue()))
                    return
                }
                self.pokemons.append(contentsOf:  responseModel.cards?.map({ PokemonDetailVM(model: $0 )}) ?? [])
                self.state?(.success)
            }
        .store(in: &subscriptions)
    }
    
    private func createBlockOperation() {
        let operation = BlockOperation()
        operation.addExecutionBlock { [weak self]in
            sleep(UInt32(1))
            if operation.isCancelled {
                return
            }
            self?.startSearch()
        }
        operationQueue.addOperation(operation)
    }
}
