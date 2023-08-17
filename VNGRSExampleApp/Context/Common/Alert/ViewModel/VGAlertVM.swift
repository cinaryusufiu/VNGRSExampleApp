//
//  VGAlertVM.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Cinar on 16.08.2023.
//

import Foundation

final class VGAlertVM: VGBaseVM {
    
    var descriptionText: String
    var closeButtonTitle: String?
    var doneButtonTitle: String?
    
    init(descriptionText: String,
         closeButtonTitle: String?,
         doneButtonTitle: String?){
        self.descriptionText = descriptionText
        self.closeButtonTitle = closeButtonTitle
        self.doneButtonTitle = doneButtonTitle
    }
}
