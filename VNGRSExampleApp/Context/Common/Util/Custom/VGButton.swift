//
//  VGButton.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit
import SnapKit

typealias CompletionButtonBlock = (_ button: UIButton) -> Void

final class VGButton: UIButton {
    
    var style : VGButtonStyle? { didSet { prepareUI() } }
    var buttonOnTapped: CompletionBlock!
    
    var touchUp: CompletionButtonBlock?
    var touchDown: CompletionButtonBlock?
    var touchExit: CompletionButtonBlock?
    
    private lazy var color = UIColor.red
    
    enum VGButtonStyle {
        case icon
        case custom
    }
    
    var title: String? = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    var margin: CGFloat = 0
    
    var bGColor: UIColor = AppColor.clear {
        didSet {
            self.backgroundColor = bGColor
        }
    }
    
    var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    var iconName: String = "" {
        didSet {
              self.setImage(UIImage(named: iconName)?
                .withRenderingMode(.alwaysOriginal)
                .withAlignmentRectInsets(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)),for: .normal)
        }
    }
    
    var titleColor: UIColor = AppColor.clear {
        didSet {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    var fontLabel: UIFont? = UIFont.systemFont(ofSize: 20){
        didSet {
            self.titleLabel?.font = fontLabel
        }
    }
    
    convenience init() {
        self.init(type: .system)
        prepareUI()
    }
    
    convenience init(style: VGButtonStyle) {
        self.init(type: .system)
        self.style = style
        prepareUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    private func prepareUI(){
        guard let style = style else { return }
        
        switch style {
        case .icon:
            self.bGColor = AppColor.clear
            self.title = ""
            self.layer.borderWidth = 0
            self.layer.borderColor = AppColor.white.cgColor
            self.imageView?.contentMode = .scaleAspectFill
        case .custom:
            self.bGColor = AppColor.clear
            self.titleColor = AppColor.darkButton
            self.fontLabel = UIFont.systemFont(ofSize: 14)
            self.layer.borderWidth = 0
            self.layer.borderColor = AppColor.white.cgColor
        }
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = bGColor
        self.layer.cornerRadius = radius
        self.titleLabel?.font = fontLabel
        self.setTitleColor(titleColor, for: .normal)
        
        addTarget(self, action: #selector(touchDown(sender:)), for: [.touchDown , .touchDragEnter])
        addTarget(self, action: #selector(touchExit(sender:)), for: [.touchCancel, .touchDragExit])
        addTarget(self, action: #selector(touchUp(sender:)), for: [.touchUpInside])
    }
    
    @objc private func touchDown(sender: UIButton) {
        touchDown?(sender)
    }
    
    @objc private func touchExit(sender: UIButton) {
        touchExit?(sender)
    }
    
    @objc private func touchUp(sender: UIButton) {
        touchUp?(sender)
    }
}
