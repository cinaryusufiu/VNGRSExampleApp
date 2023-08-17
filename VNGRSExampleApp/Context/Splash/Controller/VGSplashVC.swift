//
//  VGSplashVC.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import UIKit

final class VGSplashVC: VGBaseVC<VGSplashPage ,VGBaseVM> {
    
    // MARK: - TypeAlias
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    // MARK: - Lifecycle
    
    override func loadView() {
        viewModel = VGBaseVM()
        viewPage = VGSplashPage()
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
    }
    
    private func configureRouter() {
        guard let coordinator = self.coordinator as? AppCoordinator else { return }
        
        delay(2) {
            coordinator.startMainPage()
        }
    }
}
