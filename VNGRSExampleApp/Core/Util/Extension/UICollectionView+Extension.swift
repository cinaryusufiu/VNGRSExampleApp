//
//  UICollectionView+Extension.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import Foundation

import UIKit

extension UICollectionReusableView: ReusableCell { }

extension UICollectionView {
    
    final func registerCell<T: UICollectionViewCell>(cellType: T.Type){
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.defaultIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type) -> T {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.defaultIdentifier, for: indexPath)
        guard let cell = bareCell as? T else {
          fatalError(
            "Failed to dequeue a cell with identifier \(cellType.defaultIdentifier) matching type \(cellType.self)."
          )
        }
        return cell
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
      (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type) -> T {
        let view = self.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                         withReuseIdentifier: viewType.defaultIdentifier,
                                                         for: indexPath)
        guard let typedView = view as? T else {
          fatalError(
            "Failed to dequeue a supplementary view with identifier \(viewType.defaultIdentifier) "
              + "matching type \(viewType.self). "
          )
        }
        return typedView
    }
}
