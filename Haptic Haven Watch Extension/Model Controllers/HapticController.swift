//
//  HapticController.swift
//  Haptic Haven Watch Extension
//
//  Created by Kevin Tanner on 4/4/21.
//  Copyright © 2021 David. All rights reserved.
//

import Foundation

struct HapticController {
    static let haptics: [haptic] = [
        haptic(name: "Click", type: .click),
        haptic(name: "Direction Down", type: .directionDown),
        haptic(name: "Direction Up", type: .directionUp),
        haptic(name: "Failure", type: .failure),
        haptic(name: "Notification", type: .notification),
        haptic(name: "Retry", type: .retry),
        haptic(name: "Start", type: .start),
        haptic(name: "Stop", type: .stop),
        haptic(name: "Success", type: .success),
    ]
}
// Excluded these haptics because they require a continuous background location session.
// And I didn't think you would want that was neccesary
// haptic(name: "Nav Generic Maneuver", type: .navigationGenericManeuver),
// haptic(name: "Nav Left Turn", type: .navigationLeftTurn),
// haptic(name: "Nav Right Turn", type: .navigationRightTurn),
