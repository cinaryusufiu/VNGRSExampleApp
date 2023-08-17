//
//  VGAlertHelper.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Cinar on 16.08.2023.
//

import UIKit
import Domain

final class VGAlertHelper: NSObject {
    
    static let shared = VGAlertHelper()
    
    func showAlert(description: String,
                   closeButtonTitle:String,
                   closeButtonAction: CompletionBlock? = nil) {
        showAlert(description: description,
                  closeButtonTitle: closeButtonTitle,
                  closeButtonAction:closeButtonAction,
                  doneButtonTitle: nil,
                  doneCompletionBlock: nil)
    }
    
    func showAlert(description: String,
                   closeButtonTitle:String,
                   closeButtonAction: CompletionBlock? = nil,
                   doneButtonTitle: String? = nil,
                   doneCompletionBlock: CompletionBlock? = nil) {
        
        let alertVM = createAlertVM(description: description,
                                    buttonCloseTitle: closeButtonTitle,
                                    buttonDoneTitle: doneButtonTitle)
        
        let vc = RoutingEnum.alert(alertVM).start()
        
        if let controller = vc as? VGAlertVC {
            controller.didTapDone = {
                doneCompletionBlock?()
            }
            controller.didTapClose = {
                closeButtonAction?()
            }
        }
    }
    
    func showGeneralAlert(){
        showAlert(description: "error message",
                  closeButtonTitle: "continue")
    }
    
    func showGeneralAlert(popUpModel: PopUpModel){
        showAlert(description: popUpModel.message ?? "",
                  closeButtonTitle: "continue")
    }
    
    private func createAlertVM(description: String = "",
                               buttonCloseTitle: String?,
                               buttonDoneTitle: String?) -> VGAlertVM {
        return VGAlertVM(descriptionText: description,
                       closeButtonTitle: buttonCloseTitle,
                       doneButtonTitle: buttonDoneTitle)
    }
}
