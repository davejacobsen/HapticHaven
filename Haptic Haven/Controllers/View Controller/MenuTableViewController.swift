//
//  TipsTableViewController.swift
//  Haptic Haven
//
//  Created by David on 6/13/20.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit
import SafariServices
import StoreKit
import MessageUI
import CoreHaptics

class MenuTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var appearanceSegmentedControl: UISegmentedControl!
    
    var hapticsAvailable: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
    
    /// returns true for any phone with a screen height greater than or equal to iPhone 11
    var deviceHasLargeScreen: Bool {
        view.frame.size.height >= 896
    }
    
    let twitterURLString = "https://twitter.com/davejacobseniOS"
    let githubRepoURLString = "https://github.com/davejacobsen/HapticHaven"
    let higURLString = "https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/haptics/"
    let githubHapticsURLString = "https://github.com/davejacobsen/Built-in-haptic-feedback-code"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appVersion = UIApplication.appVersion {
            versionLabel.text = "Haptic Haven version \(appVersion)"
        }
        
        tableView.isScrollEnabled = !deviceHasLargeScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /// Makes sure that the appearance type selected in the menu is consistent across views
        overrideUserInterfaceStyle = HapticController.getSelectedAppearance()
        setUpNavBarTitle()
    }
    
    func setUpNavBarTitle() {
        
        let fontColorLightMode = CGColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        let fontColorDarkMode = CGColor(red: 185/255, green: 185/255, blue: 190/255, alpha: 1)
        let assignedCGFontColor = traitCollection.userInterfaceStyle.rawValue == 1 ? fontColorLightMode : fontColorDarkMode
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: assignedCGFontColor),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)
        ]
        
        navigationController?.navigationBar.titleTextAttributes = attrs
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setUpNavBarTitle()
    }
    
    @IBAction func appearanceValueChanged(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        if appearanceSegmentedControl.selectedSegmentIndex == 0 {
            overrideUserInterfaceStyle = .unspecified
            defaults.setValue(0, forKey: HapticController.appearanceKey)
        } else if appearanceSegmentedControl.selectedSegmentIndex == 1 {
            overrideUserInterfaceStyle = .light
            defaults.setValue(1, forKey: HapticController.appearanceKey)
        } else if appearanceSegmentedControl.selectedSegmentIndex == 2 {
            overrideUserInterfaceStyle = .dark
            defaults.setValue(2, forKey: HapticController.appearanceKey)
        } else {
            print("selection error")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]: launchLink(urlString: higURLString)
        case [1,1]: launchLink(urlString: githubHapticsURLString)
        case [1,2]: launchLink(urlString: githubRepoURLString)
        case [2,0]: presentSettingsAlert()
        case [3,0]: launchAppStoreForRating()
        case [3,1]: launchShareSheet()
        case [3,2]: composeFeedbackEmail()
        default: print("No action for index path \(indexPath)")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0: return 17
        case 1: return 40
        case 2: return 40
        case 3: return 30
        case 4: return 20
        default: return 0
            
        }
    }
    
    func launchLink(urlString: String) {
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func presentSettingsAlert() {
        
        let alertController = UIAlertController (title: "Not feeling anything?", message: "Haptics must be toggled on in your phone's Settings app in order for this app to demonstrate haptic feedback.\n\n1. Go to Settings > Sound & Haptics.\n2. Toggle on System Haptics.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
    
    func launchShareSheet() {
        
        if let appURL = NSURL(string: "https://apps.apple.com/us/app/id1523772947") {
            let objectsToShare: [Any] = [appURL]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = tableView
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func launchAppStoreForRating() {
        
        if let url = URL(string: "itms-apps://apple.com/app/id1523772947") {
            UIApplication.shared.open(url)
        } else {
            print("error with app store URL")
        }
    }
    
    @IBAction func twitterHandleTapped(_ sender: Any) {
        launchLink(urlString: twitterURLString)
    }
}

extension MenuTableViewController: MFMailComposeViewControllerDelegate {
    
    func composeFeedbackEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = configuredMailComposeViewController()
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        var messageBody: String
        
        let deviceModelName = UIDevice.modelName
        let iOSVersion = UIDevice.current.systemVersion
        let topDivider = "------ Developer Info ------"
        let bottomDivider = "----------------------------"
        
        if let appVersion = UIApplication.appVersion {
            messageBody =  "\n\n\n\n\(topDivider)\nVersion: \(appVersion)\niOS version: \(iOSVersion)\nDevice model: \(deviceModelName)\n\(bottomDivider)"
        } else {
            messageBody = "\n\n\n\n\(topDivider)\nDevice model: \(deviceModelName)\niOS version: \(iOSVersion)\n\(bottomDivider)"
        }
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["haptichaven@gmail.com"])
        mailComposerVC.setSubject("Haptic Haven Feedback")
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
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
