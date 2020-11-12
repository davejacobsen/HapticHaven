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

class PlayViewController: UIViewController {
    
    @IBOutlet var cardViews: [EMTNeumorphicView]!
    @IBOutlet var playButtons: [EMTNeumorphicButton]!
    @IBOutlet var infoButtons: [EMTNeumorphicButton]!
    @IBOutlet var shareButtons: [EMTNeumorphicButton]!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var titleLabels: [UILabel]!
    
    var tapCount = 0
    let rateAlertTriggerCount = 80
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
        HapticController.playLightImpact()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func mediumImpactButtonTapped(_ sender: UIButton) {
        HapticController.playMediumImpact()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func heavyImpactButtonTapped(_ sender: UIButton) {
        HapticController.playHeavyImpact()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func rigidImpactButtonTapped(_ sender: UIButton) {
        HapticController.playRigidImpact()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func softImpactButtonTapped(_ sender: UIButton) {
        HapticController.playSoftImpact()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func successNotificationButtonTapped(_ sender: UIButton) {
        HapticController.playSuccessNotification()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func errorNotificationButtonTapped(_ sender: UIButton) {
        HapticController.playErrorNotification()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func warningNotificationButtonTapped(_ sender: UIButton) {
        HapticController.playWarningNotification()
        incrementTapCount()
        sender.pulsate()
    }
    
    @IBAction func selectionChangedButtonTapped(_ sender: UIButton) {
        HapticController.playSelectionChangedNotification()
        incrementTapCount()
        sender.pulsate()
    }
    
    func incrementTapCount() {
        
        let defaults = UserDefaults.standard
        let presentedRatePrompt = defaults.bool(forKey: "presentedRatePrompt")
        
        guard presentedRatePrompt == false else { return }
        
        tapCount += 1
        if tapCount == rateAlertTriggerCount {
            presentRateAlert()
            defaults.set(true, forKey: "presentedRatePrompt")
        }
    }
    
    func presentRateAlert() {
        
        let defaults = UserDefaults.standard
        let presentedRatePrompt = defaults.bool(forKey: "presentedRatePrompt")
        guard presentedRatePrompt == false else { return }
        
        let title = "Enjoying Haptic Haven?"
        let message = "\nIf you have found this app useful, consider taking a moment to rate it. This helps keep the app free and without ads.\n\nThis is the only time you'll ever be asked. Thank you!"
        let actionTitle = "I have 2 seconds"
        let dismiss = "Not now"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: { (_) in
            self.rateApp()
        }))
        alert.addAction(UIAlertAction(title: dismiss, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func rateApp() {
        
        guard let scene = view.window?.windowScene else {
            print("no scene")
            return
        }
        
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview(in: scene)
        } else if let url = URL(string: "itms-apps://apple.com/app/id1523772947") {
            UIApplication.shared.open(url)
        } else {
            print("error with app rating")
        }
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
