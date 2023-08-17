//
//  VGBasePage.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit
import SnapKit

class VGBasePage: UIView {
    
    //MARK: - UI Properties
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
   
    init() {
        super.init(frame: .zero)
        prepareUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Functions
    
    func configureScrollView() {
        if subviews.contains(scrollView) {
            scrollView.removeFromSuperview()
        }
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        configureAnchorStackAndScroll()
        setupStackView()
    }
    
    func configureAnchorStackAndScroll() {
        scrollView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.width.equalTo(scrollView.snp.width)
        }
    }
    
    func setupStackView() {
        stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
    }
    
    func prepareUI() { self.backgroundColor = AppColor.clear }
    func updateUI() { }
    func updateViewModel() { }
}
