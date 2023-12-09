//
//  Crypto_PulseApp.swift
//  Crypto Pulse
//
//  Created by Nephthali Salam on 2023/12/09.
//

import SwiftUI

@main
struct Crypto_PulseApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView().frame(width: 0, height: 0)
        }
    }
}
