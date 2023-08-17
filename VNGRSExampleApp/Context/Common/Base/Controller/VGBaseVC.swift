//
//  VGBaseVC.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit
import SnapKit
import Domain

protocol VGBaseVMDataSource: NSObjectProtocol {
    associatedtype VMType: VGBaseVM
    var viewModel: VMType? { get set }
}

protocol VGBasePageDataSource: NSObjectProtocol {
    associatedtype ViewPage: VGBasePage
    var viewPage: ViewPage? { get set }
}


class VGBaseVC<T: VGBasePage, U: VGBaseVM>: UIViewController, VGBaseVMDataSource , VGBasePageDataSource {
  
    struct Constant {
         var spacing: CGFloat = 32
    }
    
    // MARK: - Properties
    
    
    weak var coordinator: Coordinator?
    var viewPage: T?
    var viewModel: U?
    
    var routingEnum: RoutingEnum? {
        didSet {
            configureInit()
        }
    }
 
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        prepareUI()
        prepareMainView()
        bindUI()
    }
    
    // MARK: - Private Functions
    
    private func bindUI() {
        viewModel?.state = { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    AppLoadingHelper.shared.hide()
                    self.updateUI()
                }
            case .failure(let popUpModel):
                DispatchQueue.main.async {
                    AppLoadingHelper.shared.hide()
                    self.showAlert(popUpModel: popUpModel)
                    self.completeFailureUI()
                }
            case .loading(let isShow):
                if isShow {
                    DispatchQueue.main.async {
                        AppLoadingHelper.shared.show()
                    }
                }
                self.prepareloadingUI()
            case .completed:
                DispatchQueue.main.async {
                    AppLoadingHelper.shared.hide()
                    self.completeUI()
                }
            }
        }
    }
    
    //MARK: - Override Functions
    
    func prepareUI() {}
    func updateUI() { }
    func completeUI() { }
    func completeFailureUI() { }
    func prepareloadingUI() { }
    func configureInit() { }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(popUpModel: PopUpModel?){
        if let popUpMdl = popUpModel {
            VGAlertHelper.shared.showGeneralAlert(popUpModel: popUpMdl)
            return
        }
        VGAlertHelper.shared.showGeneralAlert()
    }
    
    private func prepareMainView(){
        guard let viewPage = viewPage else {
            return
        }
        view.addSubview(viewPage)
        viewPage.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
}

extension VGBaseVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
