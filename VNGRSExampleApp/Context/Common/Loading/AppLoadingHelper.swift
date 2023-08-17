//
//  AppLoadingHelper.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit
import Lottie
import SnapKit

final class AppLoadingHelper {
    
    static let shared = AppLoadingHelper()
    
    private let activityView: AppLoadingView = AppLoadingView()
    
    private init(){}
    
    func show(){
        guard let window = UIApplication.shared.keyWindow else { return }
        self.activityView.frame = window.frame
        window.addSubview(self.activityView)
    }
    
    func hide(){
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveLinear, animations: {
            self.activityView.removeFromSuperview()
        })
    }
}
