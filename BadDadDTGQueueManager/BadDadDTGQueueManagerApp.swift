import SwiftUI
import AppKit

// Menu bar icon - uses NSStatusItem (MenuBarExtra requires macOS 13)
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "printer.fill", accessibilityDescription: "Queue")
        }
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Open Queue Manager", action: #selector(openApp), keyEquivalent: ""))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem?.menu = menu
    }

    @objc func openApp() {
        NSApp.activate(ignoringOtherApps: true)
    }
}

@main
struct BadDadDTGQueueManagerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            QueueView()
                .frame(minWidth: 600, minHeight: 500)
        }
        .windowToolbarStyle(.unified)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About BadDadDTG Queue Manager") {
                    // Will implement later
                }
            }
        }

        Settings {
            SettingsView()
        }
    }
}
