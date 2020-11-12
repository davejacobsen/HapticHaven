//
//  InfoSheetViewController.swift
//  Haptic Haven
//
//  Created by David on 6/11/20.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit
import MessageUI
import EMTNeumorphicView

class InfoSheetViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeTitleLabel: UILabel!
    @IBOutlet weak var codeView: EMTNeumorphicView!
    @IBOutlet weak var descriptionView: EMTNeumorphicView!
    @IBOutlet weak var playButton: EMTNeumorphicButton!
    @IBOutlet weak var shareButton: EMTNeumorphicButton!
    
    let generalCornerRadius: CGFloat = 10
    public var haptic: Haptic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setAppearance()
        setUpViews()
    }
    
    func setAppearance() {
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
        
        if appearanceSelection == 0 {
            overrideUserInterfaceStyle = .unspecified
        } else if appearanceSelection == 1 {
            overrideUserInterfaceStyle = .light
        } else {
            overrideUserInterfaceStyle = .dark
        }
    }
    
    func setUpViews() {
        
        let lightModeColor = CGColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        let darkModeColor = CGColor(red: 34/255, green: 34/255, blue: 36/255, alpha: 1)
        let fontColorLightMode = UIColor.darkGray.cgColor
        let fontColorDarkMode = CGColor(red: 185/255, green: 185/255, blue: 190/255, alpha: 1)
        let darkModeBlackShadowOppacity: Float = 0.8
        let darkModeWhiteShadowOppacity: Float = 0.15
        let lightModeBlackShadowOppacity: Float = 0.5
        let lightModeWhiteShadowOppacity: Float = 0.99
        
        let assignedCGColor: CGColor
        let assignedCGFontColor: CGColor
        let assignedBlackShadowOppacity: Float
        let assignedWhiteShadowOppacity: Float
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
        
        switch appearanceSelection {
        case 0:
            if traitCollection.userInterfaceStyle.rawValue == 1 {
                assignedCGColor = lightModeColor
                assignedCGFontColor = fontColorLightMode
                assignedBlackShadowOppacity = lightModeBlackShadowOppacity
                assignedWhiteShadowOppacity = lightModeWhiteShadowOppacity
            } else {
                assignedCGColor = darkModeColor
                assignedCGFontColor = fontColorDarkMode
                assignedBlackShadowOppacity = darkModeBlackShadowOppacity
                assignedWhiteShadowOppacity = darkModeWhiteShadowOppacity
            }
        case 1: assignedCGColor = lightModeColor
            assignedCGFontColor = fontColorLightMode
            assignedBlackShadowOppacity = lightModeBlackShadowOppacity
            assignedWhiteShadowOppacity = lightModeWhiteShadowOppacity
        case 2: assignedCGColor = darkModeColor
            assignedCGFontColor = fontColorDarkMode
            assignedBlackShadowOppacity = darkModeBlackShadowOppacity
            assignedWhiteShadowOppacity = darkModeWhiteShadowOppacity
        default:
            assignedCGColor = lightModeColor
            assignedCGFontColor = fontColorLightMode
            assignedBlackShadowOppacity = lightModeBlackShadowOppacity
            assignedWhiteShadowOppacity = lightModeWhiteShadowOppacity
            print("error in appearance selection")
        }
        
        view.backgroundColor = UIColor(cgColor: assignedCGColor)
        
        playButton.neumorphicLayer?.elementColor = assignedCGColor
        shareButton.neumorphicLayer?.elementColor = assignedCGColor
        codeView.neumorphicLayer?.elementColor = assignedCGColor
        descriptionView.neumorphicLayer?.elementColor = assignedCGColor
        
        playButton.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
        shareButton.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
        codeView.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
        descriptionView.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
        
        playButton.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
        shareButton.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
        codeView.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
        descriptionView.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
        
        playButton.neumorphicLayer?.borderColor = assignedCGColor
        playButton.neumorphicLayer?.elementBackgroundColor = assignedCGColor
        
        playButton.neumorphicLayer?.cornerRadius = view.frame.width * 0.06
        shareButton.neumorphicLayer?.cornerRadius = generalCornerRadius
        codeView.neumorphicLayer?.cornerRadius = generalCornerRadius
        descriptionView.neumorphicLayer?.cornerRadius = generalCornerRadius
        
        codeView.neumorphicLayer?.depthType = .concave
        descriptionView.neumorphicLayer?.depthType = .concave
        
        playButton.neumorphicLayer?.borderColor = assignedCGColor
        playButton.neumorphicLayer?.borderWidth = 1.0
        shareButton.neumorphicLayer?.borderColor = assignedCGColor
        shareButton.neumorphicLayer?.borderWidth = 3.0
        
        titleLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        codeLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        codeTitleLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        descriptionLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        playButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        playButton.setTitleColor(UIColor(cgColor: assignedCGFontColor), for: .normal)
        shareButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        
        if let haptic = haptic {
            titleLabel.text = haptic.name
            descriptionLabel.text = haptic.description
            codeLabel.text = haptic.code
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setUpViews()
    }
    
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        
        if let haptic = haptic {
            switch haptic.name {
            case HapticController.lightImpact.name:
                HapticController.playLightImpact()
            case HapticController.mediumImpact.name:
                HapticController.playMediumImpact()
            case HapticController.heavyImpact.name:
                HapticController.playHeavyImpact()
            case HapticController.softImpact.name:
                HapticController.playSoftImpact()
            case HapticController.rigidImpact.name:
                HapticController.playRigidImpact()
            case HapticController.successNotification.name:
                HapticController.playSuccessNotification()
            case HapticController.errorNotification.name:
                HapticController.playErrorNotification()
            case HapticController.warningNotification.name:
                HapticController.playWarningNotification()
            case HapticController.selectionChanged.name:
                HapticController.playSelectionChangedNotification()
            default:
                print("error")
            }
        }
        sender.pulsate()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        guard let haptic = haptic else {return}
        launchShareSheet(haptic: haptic)
    }
    
    func launchShareSheet(haptic: Haptic) {
        
        let codeString = haptic.code
        let objectsToShare: [Any] = [codeString]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = view
        
        self.present(activityVC, animated: true, completion: nil)
    }
}
