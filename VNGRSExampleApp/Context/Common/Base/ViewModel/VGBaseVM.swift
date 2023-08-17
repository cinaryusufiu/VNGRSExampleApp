//
//  VGBaseVM.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain

typealias ClosureState = (_ state : StateType) -> Void

struct VGBaseVMConstant {
    var screenName: String = "VGBaseVMConstant"
    var analyticsName: String = "VGBaseVMConstant"
}

enum StateType: Equatable {
    case success
    case loading(Bool)
    case completed
    case failure(PopUpModel?)

    static func == (lhs: StateType, rhs: StateType) -> Bool {
        switch (lhs, rhs) {
        case (.failure, .failure):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (.completed, .completed):
            return true
        default:
            return false
        }
    }
}

class VGBaseVM {
    
    enum StateErrorType {
        case notFound
        case parserNotWork
        case unknown
        
        func getValue() -> PopUpModel {
            switch self {
            case .notFound:
                return PopUpModel(title: "Error", message: "Not Found ", type: .error)
            case .parserNotWork:
                return PopUpModel(title: "Error", message: "Couldnt not work parser", type: .error)
            case .unknown:
                return PopUpModel(title: "Error", message: "Unknown Error", type: .error)
            }
        }
    }
    var state: ClosureState?
    
    var constant: VGBaseVMConstant {
        return VGBaseVMConstant()
    }
    
    func configureInit() {
        
    }
    
    init() {
        configureInit()
    }
}
