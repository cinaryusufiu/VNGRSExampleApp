//
//  PokemonDetailPage.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit

final class PokemonDetailPage: VGBasePage {
    
    struct Constant {
        static let heightBanner: CGFloat = 244
    }
    
    //MARK: - Properties

    var didTapLikeButton: CompletionBlock?
    
    var viewModel: PokemonDetailVM? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI Properties
    
    private let labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = AppColor.darkBlue
        label.numberOfLines = 0
        return label
    }()
    
    private let imageViewPoster: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var buttonLike: VGButton = {
        let button = VGButton(style: .custom)
        button.title = "Fav"
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.bGColor = AppColor.yellowTan
        return button
    }()
    
    // MARK: - Override Functions
    
    override func prepareUI() {
        super.prepareUI()
        configureScrollView()
        prepareSubview()
        bindUI()
    }
    
    override func configureScrollView() {
        super.configureScrollView()
        stackView.spacing = 20
        stackView.layoutMargins = .zero
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.insetsLayoutMarginsFromSafeArea = false
        stackView.insetsLayoutMarginsFromSafeArea = false
    }

    override func updateUI() {
        super.updateUI()
        imageViewPoster.loadImage(fromUrl: viewModel?.model.imageUrl)
        labelTitle.text = viewModel?.model.name
        buttonLike.bGColor = viewModel?.model.isFav ?? false ? AppColor.yellowTan : AppColor.grapePurple
    }
    
    //MARK: - Private Functions
    
    private func prepareSubview() {
        stackView.spacing = 20
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(imageViewPoster)
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(buttonLike)
        
        imageViewPoster.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(self.snp.width)
        }
    }
    
    private func bindUI() {
        buttonLike.touchUp = { [weak self] (sender) in
            self?.didTapLikeButton?()
        }
    }
}
