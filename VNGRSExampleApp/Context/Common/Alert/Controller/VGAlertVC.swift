//
//  VGAlertVC.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Cinar on 16.08.2023.
//

import UIKit

typealias CompletionBlock = (() -> ())

final class VGAlertVC: VGBaseVC<VGAlertPage, VGAlertVM>  {

    // MARK: - Properties
    
    var didTapDone: CompletionBlock?
    var didTapClose: CompletionBlock?
    
    
    // MARK: - Override Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureInitStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        viewPage = VGAlertPage()
        super.loadView()
    }
    
    override func configureInit() {
        super.configureInit()
        guard let routingEnum = routingEnum, case let RoutingEnum.alert(viewModel: viewModel) = routingEnum else { return }
        self.viewModel = viewModel
        viewPage?.viewModel = self.viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    // MARK: - private Functions
    
   private func bindUI() {
       
       viewPage?.didTapClose = {
           self.dismiss(animated: true) { [weak self] in
               self?.didTapClose?()
           }
       }
       
       viewPage?.didTapDone = {
           self.dismiss(animated: true){ [weak self] in
               self?.didTapDone?()
           }
       }
    }

    private func configureInitStyle() {
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.view.isOpaque = true
        self.view.backgroundColor = AppColor.clear
    }
}

extension VGAlertVC: UIViewControllerTransitioningDelegate {
    
    //MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return VGAlertHelperVCAnimation(isPresenting : true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return VGAlertHelperVCAnimation(isPresenting : false)
    }
}
