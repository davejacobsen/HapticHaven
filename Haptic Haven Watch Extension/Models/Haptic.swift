//
//  Haptic.swift
//  Haptic Haven Watch Extension
//
//  Created by Kevin Tanner on 4/4/21.
//  Copyright © 2021 David. All rights reserved.
//

import SwiftUI

struct haptic: Hashable {
    let id = UUID()
    let name: String
    let type: WKHapticType
}
