//
//  NavigationManager.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import UIKit

final class NavigationManager {

    typealias CompletionBlock = (() -> ())
    
    static let shared = NavigationManager()

    func topVC() -> UIViewController? {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        return topVC(rootController)
    }

    private func topVC(_ rootVC: UIViewController?) -> UIViewController? {
        guard let rootVC = rootVC else {
            return nil
        }
        if rootVC is UITabBarController {
            let tabBarVC = (rootVC as? UITabBarController)!
            return self.topVC(tabBarVC.selectedViewController!)
        }
        if rootVC is UINavigationController {
            let navigationController = (rootVC as? UINavigationController)
            if let viewController = navigationController?.visibleViewController {
                return self.topVC(viewController)
            }
          return rootVC
        }
        if rootVC is UIPageViewController {
            let controller = (rootVC as? UIPageViewController)?.viewControllers?.last
            return self.topVC(controller)
        }
        return rootVC
    }

    func popToMain(completion: (CompletionBlock)? = nil) {
        if let topVC = topVC() {
            closeTopVC(topVC, completion: completion)
            return
        }
        completion?()
    }

    func dismissTopController () {
        let topVC = NavigationManager.shared.topVC()
        topVC?.dismiss(animated: true, completion: nil)
    }

    func popViewController () {
        let topVC = NavigationManager.shared.topVC()
        topVC?.navigationController?.popViewController(animated: true)
    }
    
    func popToRootNavigationVC() {
        let topVC = NavigationManager.shared.topVC()
        topVC?.navigationController?.popToRootViewController(animated: true)
    }

    private func closeTopVC(_ viewController: UIViewController, completion: (CompletionBlock)? = nil) {
        if viewController.presentingViewController != nil {
            viewController.dismiss(animated: true) {
                if let topVC = self.topVC() {
                    self.closeTopVC(topVC, completion: completion)
                }
            }
            return
        }
        
        if viewController.navigationController != nil && viewController.navigationController?.viewControllers.count ?? 0 > 1 {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                if let topVC = self.topVC() {
                    self.closeTopVC(topVC, completion: completion)
                }
            }
            viewController.navigationController?.popToRootViewController(animated: true)
            CATransaction.commit()
            return
        }
        completion?()
    }
}
