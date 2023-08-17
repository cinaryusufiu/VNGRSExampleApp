//
//  UIStackView+Extension.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import UIKit

extension UIStackView {
    
    func arrangedSubviews(isHidden: Bool) {
        arrangedSubviews.forEach { $0.isHidden = isHidden }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

func delay(_ time: Double, _ completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        completion()
    }
}
