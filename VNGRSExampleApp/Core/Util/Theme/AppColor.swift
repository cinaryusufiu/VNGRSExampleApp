//
//  AppColor.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit

extension AppColor {
    
    enum ColorName: String {
        case grapePurple
        case almostBlack
        case white
        case dark
        case buttonColor
        case red
        case darkGreyBlue
        case yellowTan
        case grapefruit
        case lightBrightGreen
        case lightishBlue
        case darkBlue
        case pastelPurple
        case paleGrey
        case black
        case systemGreen
        case darkButton
        case dark60
    }
    
    static func findColor(name: ColorName) -> UIColor {
        guard let color = UIColor(named: name.rawValue) else {
            return .clear
        }
        return color
    }
}

enum AppColor {
    static let grapePurple = findColor(name: ColorName.grapePurple)
    static let almostBlack = findColor(name: ColorName.almostBlack)
    static let white = findColor(name: ColorName.white)
    static let dark = findColor(name: ColorName.dark)
    static let buttonColor = findColor(name: ColorName.buttonColor)
    static let red = findColor(name: ColorName.red)
    static let darkGreyBlue = findColor(name: ColorName.darkGreyBlue)
    static let yellowTan = findColor(name: ColorName.yellowTan)
    static let grapefruit = findColor(name: ColorName.grapefruit)
    static let lightBrightGreen = findColor(name: ColorName.lightBrightGreen)
    static let lightishBlue = findColor(name: ColorName.lightishBlue)
    static let darkBlue = findColor(name: ColorName.darkBlue)
    static let pastelPurple = findColor(name: ColorName.pastelPurple)
    static let paleGrey = findColor(name: ColorName.paleGrey)
    static let black = findColor(name: ColorName.black)
    static let systemGreen = findColor(name: ColorName.systemGreen)
    static let darkButton = findColor(name: ColorName.darkButton)
    static let dark60 = findColor(name: ColorName.dark60)
    static let clear = UIColor.clear
}
