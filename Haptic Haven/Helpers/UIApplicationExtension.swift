//
//  UIApplicationExtension.swift
//  Haptic Haven
//
//  Created by David on 11/7/20.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

/// Used to display the app version in the menu and gets attached to feedback emails

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
