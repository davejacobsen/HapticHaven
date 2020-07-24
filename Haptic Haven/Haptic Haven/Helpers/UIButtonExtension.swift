//
//  HapticButton.swift
//  Haptic Haven
//
//  Created by David on 6/12/20.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

extension UIButton {
    func pulsate() {
      let pulse = CASpringAnimation(keyPath: "transform.scale")
      pulse.duration = 0.055
        pulse.fromValue = 0.97
      pulse.toValue = 1.0
      pulse.initialVelocity = 0.2
        pulse.damping = 0.2
      layer.add(pulse, forKey: nil)
      }
}
