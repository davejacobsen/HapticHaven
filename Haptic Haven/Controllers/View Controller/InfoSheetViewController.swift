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
    @IBOutlet weak var intensitySlider: UISlider!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var intensityTitleLabel: UILabel!
    @IBOutlet weak var maxIntensityLabel: UILabel!
    @IBOutlet weak var minIntensityLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    /// used for all elements except the play button
    let generalCornerRadius: CGFloat = 10
    public var haptic: Haptic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /// Makes sure that the appearance type selected in the menu is consistent across views
        overrideUserInterfaceStyle = HapticController.getSelectedAppearance()
        setUpViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updateNeededForHapticTitles"), object: nil)
    }
    
    func setUpViews() {
        
        let assignedCGColor: CGColor
        let assignedCGFontColor: CGColor
        let assignedBlackShadowOppacity: Float
        let assignedWhiteShadowOppacity: Float
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: HapticController.appearanceKey)
        
        switch appearanceSelection {
        case 0:
            if traitCollection.userInterfaceStyle.rawValue == 1 {
                assignedCGColor = HapticController.lightModeColor
                assignedCGFontColor = HapticController.fontColorLightMode
                assignedBlackShadowOppacity = HapticController.lightModeBlackShadowOppacity
                assignedWhiteShadowOppacity = HapticController.lightModeWhiteShadowOppacity
            } else {
                assignedCGColor = HapticController.darkModeColor
                assignedCGFontColor = HapticController.fontColorDarkMode
                assignedBlackShadowOppacity = HapticController.darkModeBlackShadowOppacity
                assignedWhiteShadowOppacity = HapticController.darkModeWhiteShadowOppacity
            }
        case 1: assignedCGColor = HapticController.lightModeColor
            assignedCGFontColor = HapticController.fontColorLightMode
            assignedBlackShadowOppacity = HapticController.lightModeBlackShadowOppacity
            assignedWhiteShadowOppacity = HapticController.lightModeWhiteShadowOppacity
        case 2: assignedCGColor = HapticController.darkModeColor
            assignedCGFontColor = HapticController.fontColorDarkMode
            assignedBlackShadowOppacity = HapticController.darkModeBlackShadowOppacity
            assignedWhiteShadowOppacity = HapticController.darkModeWhiteShadowOppacity
        default:
            assignedCGColor = HapticController.lightModeColor
            assignedCGFontColor = HapticController.fontColorLightMode
            assignedBlackShadowOppacity = HapticController.lightModeBlackShadowOppacity
            assignedWhiteShadowOppacity = HapticController.lightModeWhiteShadowOppacity
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
        
        playButton.neumorphicLayer?.cornerRadius = view.frame.width * 0.04
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
        intensityTitleLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        intensityLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        minIntensityLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        maxIntensityLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        infoButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        codeLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        codeTitleLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        descriptionLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        playButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        playButton.setTitleColor(UIColor(cgColor: assignedCGFontColor), for: .normal)
        shareButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        
        if let haptic = haptic {
            titleLabel.text = haptic.name
            descriptionLabel.text = haptic.description
            if let intensity = haptic.intensity {
                codeLabel.text = "\(haptic.code)\(intensity))"
                intensitySlider.value = Float(intensity)
                intensityLabel.text = "\(intensity)"
            } else {
                codeLabel.text = haptic.code
                hideIntensityElements()
                playButton.translatesAutoresizingMaskIntoConstraints = false
                playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
            }
        }
    }
    
    /// called when the assigned haptic has no assigned intensity
    func hideIntensityElements() {
        intensitySlider.isHidden = true
        intensityLabel.isHidden = true
        intensityTitleLabel.isHidden = true
        minIntensityLabel.isHidden = true
        maxIntensityLabel.isHidden = true
        infoButton.isHidden = true
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
    
    @IBAction func IntensityValueChanged(_ sender: Any) {
        
        if let unwrappedHaptic = haptic {
            
            guard unwrappedHaptic.intensity != nil else { return }
            let sliderCGFloatValue = CGFloat(intensitySlider.value)
            let roundedSliderCGFloatValue = round(100.0 * sliderCGFloatValue) / 100.0

            haptic?.intensity = roundedSliderCGFloatValue
            
            switch unwrappedHaptic.name {
            case HapticController.lightImpact.name:
                HapticController.lightImpact.intensity = roundedSliderCGFloatValue
                codeLabel.text = "\(HapticController.lightImpact.code)\(HapticController.lightImpact.intensity!))"
                intensityLabel.text = "\(HapticController.lightImpact.intensity!)"
            case HapticController.mediumImpact.name:
                HapticController.mediumImpact.intensity = roundedSliderCGFloatValue
                codeLabel.text = "\(HapticController.mediumImpact.code)\(HapticController.mediumImpact.intensity!))"
                intensityLabel.text = "\(HapticController.mediumImpact.intensity!)"
            case HapticController.heavyImpact.name:
                HapticController.heavyImpact.intensity = roundedSliderCGFloatValue
                codeLabel.text = "\(HapticController.heavyImpact.code)\(HapticController.heavyImpact.intensity!))"
                intensityLabel.text = "\(HapticController.heavyImpact.intensity!)"
            case HapticController.softImpact.name:
                HapticController.softImpact.intensity = roundedSliderCGFloatValue
                codeLabel.text = "\(HapticController.softImpact.code)\(HapticController.softImpact.intensity!))"
                intensityLabel.text = "\(HapticController.softImpact.intensity!)"
            case HapticController.rigidImpact.name:
                HapticController.rigidImpact.intensity = roundedSliderCGFloatValue
                codeLabel.text = "\(HapticController.rigidImpact.code)\(HapticController.rigidImpact.intensity!))"
                intensityLabel.text = "\(HapticController.rigidImpact.intensity!)"
            default:
                print("error in setting haptic intensity")
            }
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        
        let title = "Haptic Intensity"
        let message = "\nAll 'impact' haptic feedback types have a configurable intensity property which determines the strength of the haptic.\n\nThe default CGFloat value for intensity is 1.0, which is the maximum intensity."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        guard let haptic = haptic else {return}
        launchShareSheet(haptic: haptic)
    }
    
    func launchShareSheet(haptic: Haptic) {
        
        let codeString: String
        
        if let intensity = haptic.intensity {
            codeString = "\(haptic.code)\(intensity))"
        } else {
            codeString = haptic.code
        }
        let objectsToShare: [Any] = [codeString]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = view
        
        self.present(activityVC, animated: true, completion: nil)
    }
}
