//
//  ContentView.swift
//  Haptic Haven Watch Extension
//
//  Created by Kevin Tanner on 4/4/21.
//  Copyright © 2021 David. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    private let haptics = HapticController.haptics
    private var device = WKInterfaceDevice.current()
    
    var body: some View {
        List(haptics, id: \.self) { haptic in
            Button("\(haptic.name)") {
                device.play(haptic.type)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
