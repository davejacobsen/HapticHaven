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
    
    let iconURLString = "https://www.flaticon.com/free-icon/tap_929720?k=1610381162362"
    let swiftyStoreKitURLString = "https://github.com/bizz84/SwiftyStoreKit"
    let neumorphicViewURLString = "https://github.com/hirokimu/EMTNeumorphicView"
    let twitterURLString = "https://twitter.com/davejacobseniOS"
    let youtubeURLString = "https://www.youtube.com/channel/UCpClazC2qqYfAO48NdnBeuQ"
    
    /// returns true for any phone with a screen height greater than or equal to iPhone 11
    var deviceHasLargeScreen: Bool {
        view.frame.size.height >= 896
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Makes sure that the appearance type selected in the menu is consistent across views
        overrideUserInterfaceStyle = HapticController.getSelectedAppearance()
        
        portraitImageView.layer.cornerRadius = 6
        tableView.isScrollEnabled = !deviceHasLargeScreen
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
        case [1,0]: launchLink(urlString: youtubeURLString)
        case [1,1]: launchLink(urlString: twitterURLString)
        case [2,0]: print("launching tip jar")
        case [2,1]: launchReview()
        case [3,0]: launchLink(urlString: neumorphicViewURLString)
        case [3,1]: launchLink(urlString: swiftyStoreKitURLString)
        case [3,2]: launchLink(urlString: iconURLString)
        default: print("no action triggered for index path \(indexPath)")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func launchLink(urlString: String) {
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func launchReview() {
        
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id1523772947?action=write-review")
        else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
}
