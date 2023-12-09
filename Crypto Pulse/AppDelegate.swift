//
//  AppDelegate.swift
//  Crypto Pulse
//
//  Created by Nephthali Salam on 2023/12/09.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var menuBarCoinViewModel: MenuBarCoinViewModel!
    var popoverCoinViewModel: PopoverCoinViewModel!
    let coinCapService = CoinCapPriceService()
    var statusItem: NSStatusItem!
    let popover = NSPopover()
    
    private lazy var contentView: NSView? = {
        let view = (statusItem.value(forKey: "window") as? NSWindow)?.contentView
        return view
    }()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupCoinCapService()
        setupMenuBar()
        setupPopover()
    }
    
    func setupCoinCapService() {
        coinCapService.connect()
        coinCapService.startMonitorNetworkConnectivity()
    }
}

// MARK: - MENU BAR

extension AppDelegate {
    
    func setupMenuBar() {
        menuBarCoinViewModel = MenuBarCoinViewModel(service: coinCapService)
        statusItem = NSStatusBar.system.statusItem(withLength: 64)
        guard let contentView = self.contentView,
            let menuButton = statusItem.button
        else { return }
        
        let hostingView = NSHostingView(rootView: MenuBarCoinView(viewModel: menuBarCoinViewModel))
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingView)
        
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
        
        menuButton.action = #selector(handleClickMenuButton)
    }
    
    @objc func handleClickMenuButton() {
        if popover.isShown {
            popover.performClose(nil)
            return
        }
        
        guard let menuButton = statusItem.button else { return }
        
        popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
        popover.contentViewController?.view.window?.makeKey()
    }
    
}

// MARK: - POPOVER

extension AppDelegate {
    
    func setupPopover() {
        popoverCoinViewModel = .init(service: coinCapService)
        popover.behavior = .transient
        popover.animates = true
        popover.contentSize = .init(width: 300, height: 280)
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(
            rootView: PopoverCoinView(viewModel: popoverCoinViewModel).frame(maxWidth: .infinity, maxHeight: .infinity).padding()
        )
    }
}
