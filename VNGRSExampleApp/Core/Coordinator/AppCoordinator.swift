//
//  AppCoordinator.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
  
    func start() {
        let vcSplash: VGSplashVC = VGSplashVC()
        vcSplash.coordinator = self
        let nav = UINavigationController(rootViewController: vcSplash)
        nav.isNavigationBarHidden = true
        nav.modalPresentationStyle = .fullScreen
        nav.view.backgroundColor = AppColor.white
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func startMainPage(){
        let vcMain = MainTabbarVC()
        vcMain.coordinator = self
        window?.rootViewController = MainTabbarVC()
        window?.makeKeyAndVisible()
    }
}
