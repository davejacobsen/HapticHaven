//
//  TipsTableViewController.swift
//  Haptic Haven
//
//  Created by David on 6/13/20.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit
import SafariServices

class TipsTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]: presentHIGLink()
        case [0,1]: presentCodeLink()
        case [0,2]: print("blank")
        case [1,0]: presentSettingsAlert()
        tableView.deselectRow(at: indexPath, animated: true)
        default: print("error with row selection")
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
}
