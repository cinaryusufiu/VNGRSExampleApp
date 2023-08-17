//
//  RoutingEnum.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import Foundation
import UIKit

enum RoutingEnum {
    
    case pokemonDetail(PokemonDetailVM)
    case alert(VGAlertVM)
    
    @discardableResult func start(type: PresentStyle = .push) -> UIViewController? {
        guard let vc = NavigationManager.shared.topVC() else { return nil }
        switch self {
        case .pokemonDetail:
            let controller = PokemonDetailVC()
            controller.routingEnum = self
            self.present(controller, style: type)
        case .alert:
            let controller = VGAlertVC()
            controller.routingEnum = self
            vc.present(controller, animated: true)
            return controller
        }
        return nil
    }
}

extension RoutingEnum {
    
    enum PresentStyle {
        case present
        case push
    }
    
    private func present(_ controller: UIViewController, style: PresentStyle = .present) {
        guard let vc = NavigationManager.shared.topVC() else { return }
        switch style {
        case .present:
            let navController = UINavigationController(rootViewController: controller)
            navController.isNavigationBarHidden = true
            navController.modalPresentationStyle = .fullScreen
            vc.present(navController, animated: true)
        case .push:
            guard let navBar = vc.navigationController else { return }
            navBar.pushViewController(controller, animated: true)
        }
    }
}

