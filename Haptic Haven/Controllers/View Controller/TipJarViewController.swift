//
//  TipJarViewController.swift
//  Haptic Haven
//
//  Created by David on 2/17/21.
//  Copyright © 2021 David. All rights reserved.
//

import UIKit
import EMTNeumorphicView
import SwiftyStoreKit

class TipJarViewController: UIViewController {
    
    @IBOutlet weak var textView: EMTNeumorphicView!
    @IBOutlet var tipButtons: [EMTNeumorphicButton]!
    @IBOutlet weak var smallTipButton: EMTNeumorphicButton!
    @IBOutlet weak var largeTipButton: EMTNeumorphicButton!
    @IBOutlet weak var descriptionLabel1: UILabel!
    @IBOutlet weak var descriptionLabel2: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tryAgainButton: EMTNeumorphicButton!
    
    let userDefaults = UserDefaults.standard
    
    let smallTipProductID = "com.ddjacobsen17.HapticHaven.smallTip"
    let largeTipProductID = "com.ddjacobsen17.HapticHaven.largeTip"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Makes sure that the appearance type selected in the menu is consistent across views
        overrideUserInterfaceStyle = HapticController.getSelectedAppearance()
        setUpViews()
        fetchTips()
        
    }

    func setUpViews() {
        
        let assignedCGColor: CGColor
        let assignedCGFontColor: CGColor
        let assignedBlackShadowOppacity: Float
        let assignedWhiteShadowOppacity: Float
        
        let appearanceSelection = userDefaults.integer(forKey: HapticController.appearanceKey)
        
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
        
        for tipButton in tipButtons {
            tipButton.layer.cornerRadius = 10
            tipButton.neumorphicLayer?.elementBackgroundColor = assignedCGColor
            tipButton.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
            tipButton.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
            tipButton.tintColor = UIColor(cgColor: assignedCGFontColor)
            tipButton.isHidden = true
        }
        
        textView.neumorphicLayer?.elementColor = assignedCGColor
        textView.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
        textView.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
        textView.neumorphicLayer?.cornerRadius = 10
        textView.neumorphicLayer?.depthType = .concave
        
        descriptionLabel1.textColor = UIColor(cgColor: assignedCGFontColor)
        descriptionLabel2.textColor = UIColor(cgColor: assignedCGFontColor)
        
        activityIndicator.hidesWhenStopped = true
        
        tryAgainButton.layer.cornerRadius = 8
        tryAgainButton.neumorphicLayer?.elementBackgroundColor = assignedCGColor
        tryAgainButton.neumorphicLayer?.darkShadowOpacity = assignedBlackShadowOppacity
        tryAgainButton.neumorphicLayer?.lightShadowOpacity = assignedWhiteShadowOppacity
        tryAgainButton.tintColor = UIColor(cgColor: assignedCGFontColor)
        
        errorLabel.textColor = UIColor(cgColor: assignedCGFontColor)
        
    }
    
    func fetchTips() {
        
        errorLabel.isHidden = true
        tryAgainButton.isHidden = true
        activityIndicator.startAnimating()
        
        SwiftyStoreKit.retrieveProductsInfo([smallTipProductID, largeTipProductID]) { [weak self] result in
            
            guard let self = self else { return }
            
            if let error = result.error {
                print("Error: \(error.localizedDescription)")
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Error retrieving tips"
                self.tryAgainButton.isHidden = false
                self.activityIndicator.stopAnimating()
            }
            
            if let invalidProductId = result.invalidProductIDs.first {
                
                print("Invalid product identifier: \(invalidProductId)")
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Error retrieving tips"
                self.tryAgainButton.isHidden = false
                self.activityIndicator.stopAnimating()
            }
            
            for product in result.retrievedProducts {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
                
                // must check for this since result.retrievedProducts is a set and not an array
                if product.productIdentifier == self.smallTipProductID {
                    self.smallTipButton.setTitle("\(priceString) tip", for: .normal)
                    self.smallTipButton.isHidden = false
                } else {
                    self.largeTipButton.setTitle("\(priceString) tip", for: .normal)
                    self.largeTipButton.isHidden = false
                }
                
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    @IBAction func smallTipTapped(_ sender: Any) {
        purchaseTip(productID: smallTipProductID)
    }
    
    @IBAction func largeTipTapped(_ sender: Any) {
        purchaseTip(productID: largeTipProductID)
    }
    
    func purchaseTip(productID: String) {
        
        SwiftyStoreKit.purchaseProduct(productID, quantity: 1, atomically: true) { result in
            switch result {
            case .success:
                print("success purchasing product: \(productID)")
                
            case .error(let error):
                print("error purchasing product: \(productID)")

                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: print("payment cancelled")
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                    
                }
            }
        }
    }
    
    @IBAction func tryAgainTapped(_ sender: Any) {
        fetchTips()
    }
    
}
