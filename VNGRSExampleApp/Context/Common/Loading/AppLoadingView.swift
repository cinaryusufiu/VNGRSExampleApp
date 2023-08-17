//
//  AppLoadingView.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit
import SnapKit
import Lottie

final class AppLoadingView: VGBaseView {

    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.animation = LottieAnimation.named("loading")
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        view.play()
        return view
    }()
    
    private let blankView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        return view
    }()
    
    func hide() {
        UIView.animate(withDuration: 0.7, delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut, animations: {
            self.animationView.alpha = 0
            self.blankView.alpha = 0
        }, completion: { _ in
            self.animationView.stop()
        })
    }
    
    func show() {
        self.animationView.play()
        UIView.animate(withDuration: 0.1,delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut, animations: {
            self.animationView.alpha = 1
            self.blankView.alpha = 0.1
        }, completion: nil)
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        self.addSubview(blankView)
        self.addSubview(animationView)
        
        blankView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(blankView)
            maker.centerY.equalTo(blankView).offset(30)
            maker.height.equalTo(54)
            maker.width.equalTo(54)
        }
    }
}
