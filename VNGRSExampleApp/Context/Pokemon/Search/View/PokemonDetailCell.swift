//
//  PokemonDetailCell.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import UIKit

final class PokemonDetailCell: VGBaseCVCell {
    
    // MARK: - Properties
    
    var viewModel: PokemonDetailVM? {
        didSet{
            updateUI()
        }
    }
    
    // MARK: - UI Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: " ")
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    // MARK: - Override Functions
    
    override func prepareUI() {
        super.prepareUI()
        self.backgroundColor = .clear
        addSubview(imageView)
        imageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    override func updateUI() {
        super.updateUI()
        guard let viewModel = viewModel else { return }
        imageView.loadImage(fromUrl: viewModel.model.imageUrl)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.kf.cancelDownloadTask()
    }
}
