//
//  AboutTableViewController.swift
//  Haptic Haven
//
//  Created by David on 1/11/21.
//  Copyright © 2021 David. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var portraitImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        
        portraitImageView.layer.cornerRadius = 6
        tableView.isScrollEnabled = false
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 10
        case 1: return 25
        case 2: return 25
        default: return 15
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]: launchYoutube()
        case [1,1]: launchTwitter()
        case [2,0]: launchSPMRepo()
        case [2,1]: launchIconLink()
        default: print("no action triggered")
        }
    }
    
    func launchYoutube() {
        let urlString = "https://www.youtube.com/channel/UCpClazC2qqYfAO48NdnBeuQ"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func launchTwitter() {
        let urlString = "https://twitter.com/davejacobseniOS"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func launchSPMRepo() {
        let urlString = "https://github.com/hirokimu/EMTNeumorphicView"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func launchIconLink() {
        let urlString = "https://www.flaticon.com/free-icon/tap_929720?k=1610381162362"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
}
