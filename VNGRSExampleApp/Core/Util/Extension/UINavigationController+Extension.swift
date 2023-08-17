//
//  UINavigationController+Extension.swift
//  photoenhancer
//
//  Created by Yusuf Cinar on 13.02.2023.
//

import UIKit

extension UINavigationController {
    
    static func navBarHeight() -> CGFloat {
        let nVc = UINavigationController(rootViewController: UIViewController(nibName: nil, bundle: nil))
        let navBarHeight = nVc.navigationBar.frame.size.height
        return navBarHeight
    }
    
    func configureBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "background")
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
