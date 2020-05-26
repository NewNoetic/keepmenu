//
//  AppDelegate.swift
//  KeepMenu
//
//  Created by Sidhant Gandhi on 4/10/20.
//  Copyright © 2020 newnoetic. All rights reserved.
//

import Cocoa
import menu_core
import menu_core_objc

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let menu = NSMenu()
    let popover = NSPopover()
    @IBOutlet weak var shortcutView: MASShortcutView!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("MenuIcon"))
            button.action = #selector(menuItemClicked(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
        constructMenu()
        
        popover.animates = false
        popover.contentViewController = KeepViewController.freshController()
        
        let shortcut = MASShortcut(keyCode: 53, modifierFlags: [.control])
        MASShortcutMonitor.shared().register(shortcut, withAction: { [weak self] in
            guard let strongSelf = self else { return }
            if (strongSelf.popover.isShown) {
                strongSelf.closePopover(sender: nil)
            } else {
                strongSelf.showPopover(sender: nil)
            }
        })
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func constructMenu() {
        menu.addItem(NSMenuItem(title: "Open KeepMenu", action: #selector(AppDelegate.showPopover(sender:)), keyEquivalent: "K"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit KeepMenu", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    }
    
    func openMenu(_ sender: Any?) {
        statusItem.menu = menu
    }
    
    @objc func menuItemClicked(_ sender: Any?) {
        let event = NSApp.currentEvent!
        if event.type == NSEvent.EventType.rightMouseUp {
            openMenu(sender)
        } else {
            togglePopover(sender)
        }
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    @objc func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
}

