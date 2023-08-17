//
//  UIImageView+Extension.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(fromUrl url: String?) {
        guard let url = URL(string: url ?? "") else { return }

        self.kf.indicatorType = .custom(indicator: CustomImageLoadingIndicator())

        KF.url(url).set(to: self)
    }
}

struct CustomImageLoadingIndicator: Indicator {

    private(set) var view: IndicatorView = {
        let view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = UIActivityIndicatorView.Style.medium
        } else {
            view.style = .gray
        }
        view.color = .white
        return view
    }()

    func startAnimatingView() {
        (view as? UIActivityIndicatorView)?.startAnimating()
    }

    func stopAnimatingView() {
        (view as? UIActivityIndicatorView)?.stopAnimating()
    }
}
