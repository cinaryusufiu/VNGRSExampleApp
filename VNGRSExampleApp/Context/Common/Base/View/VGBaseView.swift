//
//  VGBaseView.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit

class VGBaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    init() {
        super.init(frame: .zero)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareUI() { self.backgroundColor = AppColor.clear }
    func updateUI() { }
    func updateViewModel() { }
}
