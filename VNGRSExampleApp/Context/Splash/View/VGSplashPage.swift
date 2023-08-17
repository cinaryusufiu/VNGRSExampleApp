//
//  VGSplashPage.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import UIKit
import SnapKit
import Lottie

final class VGSplashPage: VGBasePage {
    
    //MARK: - UI Properties
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Splash"
        label.textColor = AppColor.almostBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    //MARK: - Override Functions
    
    override func prepareUI(){
        super.prepareUI()
        prepareSubview()
        prepareUIAnchor()
    }
    
    private func prepareSubview(){
        self.addSubview(labelTitle)
    }
    
    private func prepareUIAnchor(){
        
        labelTitle.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().multipliedBy(0.6)
            maker.height.equalToSuperview().multipliedBy(0.2)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(snp.centerY)
        }
    }
}
