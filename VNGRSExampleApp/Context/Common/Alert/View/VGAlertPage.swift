//
//  VGAlertPage.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Cinar on 16.08.2023.
//

import UIKit

final class VGAlertPage: VGBasePage {
    
    struct Constant {
        static let maxHeightField: CGFloat = 400
        static let minHeightField: CGFloat = 60
    }
    
    // MARK: - Properties
    
    var didTapDone: CompletionBlock?
    var didTapClose: CompletionBlock?
    
    var viewModel: VGAlertVM? {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - UI Properties
  
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.white
        view.clipsToBounds = true
        return view
    }()
    
    private let textViewDescription: UITextView = {
        let textView = UITextView(frame: .zero)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineSpacing = 3
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        textView.typingAttributes = attributes
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = AppColor.darkButton
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isSelectable = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var buttonClose: VGButton = {
        let button = VGButton(style: .custom)
        button.title = "buttonclose"
        button.fontLabel = UIFont.systemFont(ofSize: 20)
        button.touchUp = { [weak self] (sender) in
            self?.didTapClose?()
        }
        return button
    }()
    
    private lazy var buttonDone: VGButton = {
        let button = VGButton(style: .custom)
        button.title = "buttonDone"
        button.fontLabel = UIFont.systemFont(ofSize: 20)
        button.touchUp = { [weak self] (sender) in
            self?.didTapDone?()
        }
        return button
    }()
    
    private let viewBottomUpBorder: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.dark60
        return view
    }()
    
    private let viewBottomCenterBorder: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.dark60
        return view
    }()
    
    private let stackViewButton : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Override Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewContainer.roundCorners(.allCorners, radius: 12)
        viewContainer.layer.drawShadow(color: AppColor.red, alpha: 0.8, x: 0, y: 4, blur: 14, spread: 0)
    }
    
    override func prepareUI() {
        super.prepareUI()
        self.backgroundColor = AppColor.black.withAlphaComponent(0.5)
        addSubview(viewContainer)
        viewContainer.addSubview(textViewDescription)
        viewContainer.addSubview(stackViewButton)
        viewContainer.addSubview(viewBottomUpBorder)
        viewContainer.addSubview(viewBottomCenterBorder)
        
        viewContainer.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.8)
        }
        
        textViewDescription.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(24)
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.height.equalTo(Constant.maxHeightField)
        }
        
        stackViewButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(textViewDescription.snp.bottom).offset(12)
            maker.bottom.equalToSuperview()
            maker.height.equalTo(60)
            maker.leading.trailing.equalToSuperview()
        }
        
        viewBottomUpBorder.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(stackViewButton.snp.top).offset(1)
            maker.height.equalTo(0.5)
            maker.leading.trailing.equalToSuperview()
        }
        
        viewBottomCenterBorder.snp.makeConstraints { (maker) in
            maker.top.equalTo(viewBottomUpBorder.snp.bottom)
            maker.width.equalTo(0.5)
            maker.centerX.bottom.equalToSuperview()
        }
    }
    
    override func updateUI() {
        super.updateUI()
        
        guard let viewModel = self.viewModel else { return }
        stackViewButton.removeAllArrangedSubviews()
        stackViewButton.addArrangedSubview(buttonClose)
        
        if let _ = viewModel.doneButtonTitle {
            buttonClose.titleColor = AppColor.grapefruit
            buttonDone.titleColor = AppColor.buttonColor
            stackViewButton.addArrangedSubview(buttonDone)
            viewBottomCenterBorder.isHidden = false
        }
        else {
            buttonClose.titleColor = AppColor.buttonColor
            viewBottomCenterBorder.isHidden = true
        }
        
        textViewDescription.text = viewModel.descriptionText
        buttonDone.setTitle(viewModel.doneButtonTitle, for: .normal)
        buttonClose.setTitle(viewModel.closeButtonTitle, for: .normal)
        
        var heightInfoText: CGFloat = textViewDescription.attributedText?.height(containerWidth: 200) ?? 0
        
        if heightInfoText > Constant.maxHeightField {
            heightInfoText = Constant.maxHeightField
        }
        
        if heightInfoText < Constant.minHeightField {
            heightInfoText = Constant.minHeightField
        }
        
        if textViewDescription.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            heightInfoText = -34
        }
        
        textViewDescription.snp.updateConstraints { make in
            make.height.equalTo(heightInfoText)
        }
    }
}
