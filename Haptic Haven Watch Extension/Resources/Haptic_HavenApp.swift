//
//  Haptic_HavenApp.swift
//  Haptic Haven Watch Extension
//
//  Created by Kevin Tanner on 4/4/21.
//  Copyright © 2021 David. All rights reserved.
//

import SwiftUI

@main
struct Haptic_HavenApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
