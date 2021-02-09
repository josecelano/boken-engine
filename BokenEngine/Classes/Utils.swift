//
//  Utils.swift
//  Boken Engine
//
//  Created by Yeray on 26/11/2020.
//  Copyright © 2020 Hyve. All rights reserved.
//

import GameplayKit

enum ColorName: String, Decodable {
    case white
    case lightGrey
    case darkGrey
    case black
    case red
    case green
    case blue
    case orange
    case yellow
}

enum DeviceOrientation {
    case horizontal
    case vertical
}

func getOppositeFromBackgroundColor(scene: SKScene) -> UIColor {
    return scene.backgroundColor == UIColor.white ? UIColor.black : UIColor.white
}

func getDeviceRelativeCoordinates(view: SKView, posX: Float, posY: Float) -> CGPoint {
    return CGPoint(x: view.bounds.width * CGFloat(posX),
                   y: view.bounds.height * CGFloat(posY))
}

func getDeviceOrientation() -> DeviceOrientation {
    if UIApplication.shared.statusBarOrientation.isLandscape {
        return DeviceOrientation.horizontal
    } else {
        return DeviceOrientation.vertical
    }
}

func isLandscapeMode() -> Bool {
    return getDeviceOrientation() == DeviceOrientation.horizontal
}

func getScaleFactor(view: SKView) -> CGPoint {
    return CGPoint(x: view.bounds.size.width / 414,
                   y: view.bounds.size.height / 896)
}

func getUIColor(colorName: ColorName) -> UIColor {
    switch colorName {
    case ColorName.white:
        return UIColor.white
    case ColorName.black:
        return UIColor.black
    case ColorName.lightGrey:
        return UIColor.lightGray
    case ColorName.darkGrey:
        return UIColor.darkGray
    case ColorName.red:
        return UIColor.red
    case ColorName.green:
        return UIColor.green
    case ColorName.blue:
        return UIColor.blue
    case ColorName.orange:
        return UIColor.orange
    case ColorName.yellow:
        return UIColor.yellow
    }
}

// from https://bit.ly/2YysWE3
func isRunningTest() -> Bool {
    return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
