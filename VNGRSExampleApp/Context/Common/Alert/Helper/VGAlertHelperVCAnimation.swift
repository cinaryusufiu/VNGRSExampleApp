//
//  VGAlertHelperVCAnimation.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Cinar on 16.08.2023.
//

import UIKit

final class VGAlertHelperVCAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if isPresenting {
            return 0.3
        }
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            self.presentAnimateTransition(transitionContext)
            return
        }
        self.dismissAnimateTransition(transitionContext)
    }
    
    func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let controller: VGAlertVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? VGAlertVC else { return }
        
        let containerView = transitionContext.containerView
        controller.viewPage?.alpha = 0.0
        controller.viewPage?.center = controller.view.center
        controller.viewPage?.viewContainer.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        containerView.addSubview(controller.view)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
            controller.viewPage?.alpha = 1.0
            controller.viewPage?.viewContainer.transform =  CGAffineTransform.identity
        },completion: { finished in
            guard finished else { return }
            transitionContext.completeTransition(true)
        })
    }
    
    func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let controller = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.from) as? VGAlertVC  else { return }
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
            controller.viewPage?.viewContainer.transform = CGAffineTransform(scaleX: 0, y: 0)
            controller.viewPage?.alpha = 0.0
        },completion: { finished in
            guard finished else { return }
            transitionContext.completeTransition(true)
        })
    }
}
