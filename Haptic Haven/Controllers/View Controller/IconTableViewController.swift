//
//  IconTableViewController.swift
//  Haptic Haven
//
//  Created by David on 1/4/21.
//  Copyright © 2021 David. All rights reserved.
//

import UIKit

class IconTableViewController: UITableViewController {
    
    var icons = [Icon(image: UIImage(named: "defaultIcon")!, fileName: "AppIcon", isSelectedIcon: false), Icon(image: UIImage(named: "altIcon1")!, fileName: "altIcon1", isSelectedIcon: false), Icon(image: UIImage(named: "altIcon2")!, fileName: "altIcon2", isSelectedIcon: false), Icon(image: UIImage(named: "altIcon3")!, fileName: "altIcon3", isSelectedIcon: false), Icon(image: UIImage(named: "altIcon4")!, fileName: "altIcon4", isSelectedIcon: false)]

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /// Makes sure that the appearance type selected in the menu is consistent across views
        overrideUserInterfaceStyle = HapticController.getSelectedAppearance()
        setSelectedAppIcon()
    }
    
    func setSelectedAppIcon() {
        let iconSelection = defaults.integer(forKey: HapticController.iconSelectionKey)
        icons[iconSelection].isSelectedIcon = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        
        let icon = icons[indexPath.row]
        
        cell.imageView?.image = icon.image
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.heightAnchor.constraint(equalToConstant: 57).isActive = true
        cell.imageView?.widthAnchor.constraint(equalToConstant: 57).isActive = true
        cell.imageView?.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        cell.imageView?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        cell.imageView?.layer.cornerRadius = 13
        cell.imageView?.clipsToBounds = true
        cell.accessoryType = icon.isSelectedIcon ? .checkmark : .none
        cell.tintColor = .darkGray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /// prevents the currently selected cell from reseting the icon to the same one again
        guard !icons[indexPath.row].isSelectedIcon else {
            return
        }
        
        if let currentSelectedIconIndex = icons.firstIndex(where: {$0.isSelectedIcon == true}) {
            icons[currentSelectedIconIndex].isSelectedIcon = false
        }
        
        icons[indexPath.row].isSelectedIcon = true
        
        switch indexPath.row {
        case 0:
            print("default icon row tapped")
            UIApplication.shared.setAlternateIconName(nil) { (error) in
                guard error == nil else {
                    print("Error setting app icon: \(error!.localizedDescription)")
                    return
                }
            }
        default:
            
            UIApplication.shared.setAlternateIconName("\(icons[indexPath.row].fileName)") { (error) in
                guard error == nil else {
                    print("Error setting app icon: \(error!.localizedDescription)")
                    return
                }
                print("success changing icon")
            }
        }
        
        defaults.setValue(indexPath.row, forKey: HapticController.iconSelectionKey)
        tableView.reloadData()
    }
}
