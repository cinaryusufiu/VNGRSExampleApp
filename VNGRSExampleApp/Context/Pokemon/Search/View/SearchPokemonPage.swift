//
//  SearchPokemonPage.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import UIKit

final class SearchPokemonPage: VGBasePage {
    
    struct Constant {
        static let spacing: CGFloat = 8
    }
    
    //MARK: - Properties
    
    var didTappedCell: ((_ index: Int) -> ())?
    
    var viewModel: SearchPokemonVM? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - UI Properties
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.contentInsetAdjustmentBehavior = .never
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        return cv
    }()
    
    // MARK: - Override Functions
    
    override func prepareUI() {
        super.prepareUI()
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(Constant.spacing)
        }
        collectionView.registerCell(cellType: PokemonDetailCell.self)
    }
    
    override func updateUI() {
        super.updateUI()
        collectionView.reloadData()
    }
}

extension SearchPokemonPage: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PokemonDetailCell.self)
        cell.viewModel = viewModel?.itemVM(index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didTappedCell?(indexPath.row)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width - Constant.spacing ) / 2  , height: (self.collectionView.frame.width  * 2) / 3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spacing
    }
}
