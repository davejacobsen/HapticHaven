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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appVersion = UIApplication.appVersion {
            versionLabel.text = "Haptic Haven Version \(appVersion)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setAppearance()
        setUpTitle()
    }
    
    /// Sets the initial value of the segment control based on the previously selected value
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
        appearanceSegmentedControl.selectedSegmentIndex = appearanceSelection
        
        if appearanceSelection == 0 {
            overrideUserInterfaceStyle = .unspecified
        } else if appearanceSelection == 1 {
            overrideUserInterfaceStyle = .light
        } else {
            overrideUserInterfaceStyle = .dark
        }
    }
    
    func setUpTitle() {
        
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
        setUpTitle()
    }
    
    @IBAction func appearanceValueChanged(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        if appearanceSegmentedControl.selectedSegmentIndex == 0 {
            overrideUserInterfaceStyle = .unspecified
            defaults.setValue(0, forKey: "appearanceSelection")
        } else if appearanceSegmentedControl.selectedSegmentIndex == 1 {
            overrideUserInterfaceStyle = .light
            defaults.setValue(1, forKey: "appearanceSelection")
        } else if appearanceSegmentedControl.selectedSegmentIndex == 2 {
            overrideUserInterfaceStyle = .dark
            defaults.setValue(2, forKey: "appearanceSelection")
        } else {
            print("selection error")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]: presentHIGLink()
            tableView.deselectRow(at: indexPath, animated: true)
        case [1,1]: presentCodeLink()
            tableView.deselectRow(at: indexPath, animated: true)
        case [1,2]: presentRepoLink()
            tableView.deselectRow(at: indexPath, animated: true)
        case [2,0]: presentSettingsAlert()
            tableView.deselectRow(at: indexPath, animated: true)
        case [3,0]: promptRating()
            tableView.deselectRow(at: indexPath, animated: true)
        case [3,1]: launchShareSheet()
            tableView.deselectRow(at: indexPath, animated: true)
        case [3,2]: composeFeedbackEmail()
            tableView.deselectRow(at: indexPath, animated: true)
        default: print("error with row selection")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        /// This compresses the section spacing for screen sizes of the iphone 8(height of 667 points) or smaller
        /// Because I disable scrolling, the version label would get cut off on small screens without this
        let headerHeight1: CGFloat = view.frame.size.height > 667 ? 20 : 0.1
        let headerHeight2: CGFloat = view.frame.size.height > 667 ? 30 : 17
        
        if section == 3 {
            return headerHeight1
        } else {
            return headerHeight2
        }
    }
    
    func presentHIGLink() {
        let urlString = "https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/haptics/"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func presentCodeLink() {
        let urlString = "https://github.com/davejacobsen/Built-in-haptic-feedback-code"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func presentRepoLink() {
        let urlString = "https://github.com/davejacobsen/HapticHaven"
        
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
    
    func promptRating() {
        
        if let url = URL(string: "itms-apps://apple.com/app/id1523772947") {
            UIApplication.shared.open(url)
        } else {
            print("error with app store URL")
        }
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
        if let appVersion = UIApplication.appVersion {
            messageBody =  "\n\n\n\nVersion: \(appVersion)"
        } else {
            messageBody = "\n\n"
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
