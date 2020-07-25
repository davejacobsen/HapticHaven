//
//  HapticController.swift
//  Haptic Haven
//
//  Created by David on 6/12/20.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

struct HapticController {
    
    static let lightImpact = Haptic(name: "Light Impact", description: "The light impact haptic feedback is used to provide a physical metaphor(of light intensity) for what is occurring on screen. Often times this should be complemented by visual and/or auditory feedback such as a button's color changing when tapped. An impact haptic feedback could also be used when a user first grabs an object for drag and drop to indicate that they have picked it up and it is ready to be moved.", code: "let generator = UIImpactFeedbackGenerator(style: .light)\ngenerator.impactOccurred()")
    
    static let mediumImpact = Haptic(name: "Medium Impact", description: "The medium impact haptic feedback is used to provide a physical metaphor(of medium intensity) for what is occurring on screen. Often times this should be complemented by visual and/or auditory feedback such as a button's color changing when tapped. An impact haptic feedback could also be used when a user first grabs an object for drag and drop to indicate that they have picked it up and it is ready to be moved.", code: "let generator = UIImpactFeedbackGenerator(style: .medium)\ngenerator.impactOccurred()")
    
    static let heavyImpact = Haptic(name: "Heavy Impact", description: "The heavy impact haptic feedback is used to provide a physical metaphor(of heavy intensity) for what is occurring on screen. Often times this should be complemented by visual and/or auditory feedback such as a button's color changing when tapped. An impact haptic feedback could also be used when a user first grabs an object for drag and drop to indicate that they have picked it up and it is ready to be moved.", code: "let generator = UIImpactFeedbackGenerator(style: .heavy)\ngenerator.impactOccurred()")
    
    static let rigidImpact = Haptic(name: "Rigid Impact", description: "The rigid impact haptic feedback is used to provide a physical metaphor(with rigid intensity) for what is occurring on screen. Often times this should be complemented by visual and/or auditory feedback such as a button's color changing when tapped. An impact haptic feedback could also be used when a user first grabs an object for drag and drop to indicate that they have picked it up and it is ready to be moved.", code: "let generator = UIImpactFeedbackGenerator(style: .rigid)\ngenerator.impactOccurred()")
    
    static let softImpact = Haptic(name: "Soft Impact", description: "The soft impact haptic feedback is used to provide a physical metaphor(with soft intensity) for what is occurring on screen. Often times this should be complemented by visual and/or auditory feedback such as a button's color changing when tapped. An impact haptic feedback could also be used when a user first grabs an object for drag and drop to indicate that they have picked it up and it is ready to be moved.", code: "let generator = UIImpactFeedbackGenerator(style: .soft)\ngenerator.impactOccurred()")
    
    static let successNotification = Haptic(name: "Success Notification", description: "The success notification haptic feedback is used to indicate that a certain task or action has completed. Often times the same button or element that has a success notification haptic will also have an error notification haptic and/or warning notification haptic placed in the same element that will trigger the haptics accordingly.", code: "let generator = UINotificationFeedbackGenerator()\ngenerator.notificationOccurred(.success)")
    
    static let errorNotification = Haptic(name: "Error Notification", description: "The error notification haptic feedback is used to indicate that a certain task or action has failed or is incomplete. Often times the same button or element that has an error notification haptic will also have a success notification haptic and/or warning notification haptic placed in the same element that will trigger the haptics accordingly.", code: "let generator = UINotificationFeedbackGenerator()\ngenerator.notificationOccurred(.error)")
    
    static let warningNotification = Haptic(name: "Warning Notification", description: "The warning notification haptic feedback is used to indicate a warning to the user during an attempt to complete a task or action. Often times the same button or element that has a warning notification haptic will also have a success notification haptic and/or error notification haptic placed in the same element that will trigger the haptics accordingly.", code: "let generator = UINotificationFeedbackGenerator()\ngenerator.notificationOccurred(.warning)")
    
    static let selectionChanged = Haptic(name: "Selection Changed", description: "The selection changed haptic feedback is used to indicate that a selection is actively changing or to communicate movement through a series of set values. This haptic is built in to certain UIKit elements such as a picker.", code: "let generator = UISelectionFeedbackGenerator()\ngenerator.selectionChanged()")
    
    static func playLightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    static func playMediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    static func playHeavyImpact() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    static func playRigidImpact() {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
    }
    
    static func playSoftImpact() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
    
    static func playSuccessNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    static func playErrorNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    static func playWarningNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    static func playSelectionChangedNotification() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
