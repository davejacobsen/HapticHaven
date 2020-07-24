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

class TestViewController: UIViewController {
    
    @IBOutlet var cardViews: [EMTNeumorphicView]!
    @IBOutlet var playButtons: [EMTNeumorphicButton]!
    @IBOutlet var infoButtons: [EMTNeumorphicButton]!
    @IBOutlet var shareButtons: [EMTNeumorphicButton]!
    
    var tapCount = 0
    let rateAlertTriggerCount = 50
    let generalCornerRadius: CGFloat = 10
    let color: CGColor = .init(srgbRed: 229/255, green: 229/255, blue: 234/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        view.backgroundColor = .systemGray5
        
        for cardView in cardViews {
            cardView.layer.cornerRadius = generalCornerRadius
            cardView.neumorphicLayer?.elementBackgroundColor = color
            cardView.neumorphicLayer?.darkShadowOpacity = 0.35
        }
        
        for playButton in playButtons {
            playButton.layer.cornerRadius = 15
            playButton.neumorphicLayer?.elementBackgroundColor = color
            playButton.neumorphicLayer?.darkShadowOpacity = 0.35
        }
        
        for infoButton in infoButtons {
            infoButton.layer.cornerRadius = generalCornerRadius
            infoButton.neumorphicLayer?.elementBackgroundColor = color
            infoButton.neumorphicLayer?.darkShadowOpacity = 0.4
        }
        
        for shareButton in shareButtons {
            shareButton.layer.cornerRadius = generalCornerRadius
            shareButton.neumorphicLayer?.elementBackgroundColor = color
            shareButton.neumorphicLayer?.darkShadowOpacity = 0.4
            shareButton.neumorphicLayer?.elementDepth = 6
        }
        
        let defaults = UserDefaults.standard
        let presentedRatePrompt = defaults.bool(forKey: "presentedRatePrompt")
        defaults.set(presentedRatePrompt, forKey: "presentedRatePrompt")
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
        
        let title = "Enjoying Haptic Haven?"
        let message = "\nIf you have found this app useful, consider taking a moment to rate it. You can do so without leaving the app and this is the only time we will ever ask. Thank you!"
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
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else if let url = URL(string: "https://apps.apple.com/app/id/1523772947") {
            UIApplication.shared.openURL(url)
        }
    }
    
    // MARK: - SHARE BUTTONS
    
    @IBAction func shareLightImpactTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.lightImpact)
    }
    
    @IBAction func shareMediumImpactTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.mediumImpact)
    }
    
    @IBAction func shareHeavyImpactTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.heavyImpact)
    }
    
    @IBAction func shareRigidImpactTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.rigidImpact)
    }
    
    @IBAction func shareSoftImpactTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.softImpact)
    }
    
    @IBAction func shareSuccessNotificationTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.successNotification)
    }
    
    @IBAction func shareErrorNotificationTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.errorNotification)
    }
    
    @IBAction func shareWarningNotificationTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.warningNotification)
    }
    
    @IBAction func shareSelectionChangedTapped(_ sender: Any) {
        presentShareAlert(haptic: HapticController.selectionChanged)
    }
    
    func presentShareAlert(haptic: Haptic) {
        
        let title = "\(haptic.name) Haptic"
        let message = "\nHow would you like to send yourself the code?"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Text message", style: .default, handler: { (_) in
            self.composeShareMessage(haptic: haptic)
        }))
        alert.addAction(UIAlertAction(title: "Email", style: .default, handler: { (_) in
            self.composeShareEmail(haptic: haptic)
        }))
        
        self.present(alert, animated: true, completion: nil)
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

extension TestViewController: MFMailComposeViewControllerDelegate {
    
    func composeShareEmail(haptic: Haptic) {
        let mailComposeViewController = configuredMailComposeViewController(haptic: haptic)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController(haptic: Haptic) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        //    mailComposerVC.setToRecipients(["avokeepr@gmail.com"])
        mailComposerVC.setSubject("Code for \(haptic.name) haptic")
        mailComposerVC.setMessageBody("\(haptic.code)", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and internet connection and try again.", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension TestViewController: MFMessageComposeViewControllerDelegate {
    
    func composeShareMessage(haptic: Haptic) {
        let messageVC = MFMessageComposeViewController()
        if MFMessageComposeViewController.canSendText() {
            
            messageVC.body = "Code for \(haptic.name):\n\n\(haptic.code)";
            messageVC.messageComposeDelegate = self
            
            self.present(messageVC, animated: true, completion: nil)
            
        } else {
            showSendMessageErrorAlert()
        }
    }
    
    func showSendMessageErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Message", message: "Your device could not send a message. Please check your messages configuration or phone provider connection and try again.", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            dismiss(animated: true, completion: nil)
        case .failed:
            dismiss(animated: true, completion: nil)
        case .sent:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
}
