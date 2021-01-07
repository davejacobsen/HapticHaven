//
//  TestViewController.swift
//  Haptic Haven
//
//  Created by David on 6/11/20.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import EMTNeumorphicView
import CoreHaptics

class PlayViewController: UIViewController {
    
    @IBOutlet var cardViews: [EMTNeumorphicView]!
    @IBOutlet var playButtons: [EMTNeumorphicButton]!
    @IBOutlet var infoButtons: [EMTNeumorphicButton]!
    @IBOutlet var shareButtons: [EMTNeumorphicButton]!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var titleLabels: [UILabel]!
    
    /// An in app rating promt will attempt to fire at each int in this array
    let rateAlertTapCountArray = [175,275,400,600,1000,1500,3000]
    
    /// Used for all elements except play buttons
    let generalCornerRadius: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setAppearance()
        setupViews()
    }
    
    /// Makes sure that the appearance type selected in the menu is consistent across views
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
    
    /// Makes sure that app is synced with device's dark mode schedule
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setAppearance()
        setupViews()
    }
    
    func setupViews() {
        
        let lightModeColor = CGColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        let darkModeColor = CGColor(red: 34/255, green: 34/255, blue: 36/255, alpha: 1)
        let fontColorLightMode = UIColor.darkGray.cgColor
        let fontColorDarkMode = CGColor(red: 185/255, green: 185/255, blue: 190/255, alpha: 1)
        
        let darkModeBlackShadowOppacity: Float = 0.8
        let darkModeWhiteShadowOppacity: Float = 0.15
        let lightModeBlackShadowOppacity: Float = 0.3
        let lightModeWhiteShadowOppacity: Float = 0.99
        
        let assignedCGColor: CGColor
        let assignedCGFontColor: CGColor
        let assignedBlackShadowOppacity: Float
        let assignedWhiteShadowOppacity: Float
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
        
        /// Usually it's not this complicated to sync appearance styles, but the Swift package I used for the neumorphic look, this was the best solution I could find
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
        
        for cardView in cardViews {
            cardView.layer.cornerRadius = generalCornerRadius
            cardView.neumorphicLayer?.elementBackgroundColor = assignedCGColor
            cardView.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
            cardView.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
        }
        
        for title in titleLabels {
            title.textColor = UIColor(cgColor: assignedCGFontColor)
        }
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: assignedCGFontColor),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        
        menuButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        navigationController?.navigationBar.titleTextAttributes = attrs
        
        for playButton in playButtons {
            playButton.layer.cornerRadius = 15
            playButton.neumorphicLayer?.elementBackgroundColor = assignedCGColor
            playButton.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
            playButton.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
            playButton.tintColor = UIColor(cgColor: assignedCGFontColor)
            playButton.setTitleColor(UIColor(cgColor: assignedCGFontColor), for: .normal)
        }
        
        for infoButton in infoButtons {
            infoButton.layer.cornerRadius = generalCornerRadius
            infoButton.neumorphicLayer?.elementBackgroundColor = assignedCGColor
            infoButton.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
            infoButton.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
            infoButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        }
        
        for shareButton in shareButtons {
            shareButton.layer.cornerRadius = generalCornerRadius
            shareButton.neumorphicLayer?.elementBackgroundColor = assignedCGColor
            shareButton.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
            shareButton.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
            shareButton.neumorphicLayer?.elementDepth = 6
            shareButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        }
    }
    
    // MARK: - PLAY BUTTONS
    
    @IBAction func lightImpactButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playLightImpact()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func mediumImpactButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playMediumImpact()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func heavyImpactButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playHeavyImpact()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func rigidImpactButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playRigidImpact()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func softImpactButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playSoftImpact()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func successNotificationButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playSuccessNotification()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func errorNotificationButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playErrorNotification()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func warningNotificationButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playWarningNotification()
        incrementTapCountForRatingPrompt()
    }
    
    @IBAction func selectionChangedButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        HapticController.playSelectionChangedNotification()
        incrementTapCountForRatingPrompt()
    }
    
    func incrementTapCountForRatingPrompt() {
        
        let defaults = UserDefaults.standard
        var tapCount = defaults.integer(forKey: "tapCount")
        tapCount += 1
        defaults.setValue(tapCount, forKey: "tapCount")
        
        if rateAlertTapCountArray.contains(tapCount) {
            
            guard let scene = view.window?.windowScene else {
                print("no scene")
                return
            }
            if #available(iOS 14.0, *) {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    /// Unused for now
    func presentDeviceIncompatibleAlert() {
        
        let title = "Oh no! :("
        let message = "Your device does not have a haptic engine built in and is not compatible with haptic feedback.\n\nYou are free to explore the app but hitting a play button will not result in any vibrations."
        let actionTitle = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - SHARE BUTTONS
    
    @IBAction func shareLightImpactTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.lightImpact)
    }
    
    @IBAction func shareMediumImpactTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.mediumImpact)
    }
    
    @IBAction func shareHeavyImpactTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.heavyImpact)
    }
    
    @IBAction func shareRigidImpactTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.rigidImpact)
    }
    
    @IBAction func shareSoftImpactTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.softImpact)
    }
    
    @IBAction func shareSuccessNotificationTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.successNotification)
    }
    
    @IBAction func shareErrorNotificationTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.errorNotification)
    }
    
    @IBAction func shareWarningNotificationTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.warningNotification)
    }
    
    @IBAction func shareSelectionChangedTapped(_ sender: Any) {
        launchShareSheet(haptic: HapticController.selectionChanged)
    }
    
    func launchShareSheet(haptic: Haptic) {
        
        let codeString = haptic.code
        
        let objectsToShare: [Any] = [codeString]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = view
        
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    // MARK: - INFO BUTTONS
    
    @IBAction func lightImpactInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.lightImpact)
    }
    
    @IBAction func mediumImpactInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.mediumImpact)
    }
    
    @IBAction func heavyImpactInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.heavyImpact)
    }
    
    @IBAction func rigidImpactInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.rigidImpact)
    }
    
    @IBAction func softImpactInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.softImpact)
    }
    
    @IBAction func successNotificationInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.successNotification)
    }
    
    @IBAction func errorNotificationInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.errorNotification)
    }
    
    @IBAction func warningNotificationInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.warningNotification)
    }
    
    @IBAction func selectionChangedInfoButtonTapped(_ sender: Any) {
        presentInfoVC(haptic: HapticController.selectionChanged)
    }
    
    func presentInfoVC(haptic: Haptic) {
        let displayVC : InfoSheetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoSheetVC") as! InfoSheetViewController
        displayVC.haptic = haptic
        self.present(displayVC, animated: true, completion: nil)
    }
}
