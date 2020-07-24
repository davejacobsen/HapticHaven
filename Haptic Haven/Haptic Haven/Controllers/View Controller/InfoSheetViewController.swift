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
    @IBOutlet weak var codeView: EMTNeumorphicView!
    @IBOutlet weak var descriptionView: EMTNeumorphicView!
    @IBOutlet weak var playButton: EMTNeumorphicButton!
    @IBOutlet weak var shareButton: EMTNeumorphicButton!
    
    let generalCornerRadius: CGFloat = 10
    let playButtonCornerRadius: CGFloat = 15
    let color: CGColor = .init(srgbRed: 229/255, green: 229/255, blue: 234/255, alpha: 1)
    
    public var haptic: Haptic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        
        view.backgroundColor = .systemGray5
        playButton.neumorphicLayer?.elementColor = color
        shareButton.neumorphicLayer?.elementColor = color
        codeView.neumorphicLayer?.elementColor = color
        descriptionView.neumorphicLayer?.elementColor = color
        
        playButton.layer.cornerRadius = playButtonCornerRadius
        shareButton.layer.cornerRadius = generalCornerRadius
        codeView.layer.cornerRadius = generalCornerRadius
        descriptionView.layer.cornerRadius = generalCornerRadius
        
        codeView.neumorphicLayer?.depthType = .concave
        descriptionView.neumorphicLayer?.depthType = .concave
        
        if let haptic = haptic {
            titleLabel.text = haptic.name
            descriptionLabel.text = haptic.description
            codeLabel.text = haptic.code
        }
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
        presentShareAlert(haptic: haptic)
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
}

extension InfoSheetViewController: MFMailComposeViewControllerDelegate {
    
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
        mailComposerVC.setSubject("Code for \(haptic.name) Haptic")
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

extension InfoSheetViewController: MFMessageComposeViewControllerDelegate {
    
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
