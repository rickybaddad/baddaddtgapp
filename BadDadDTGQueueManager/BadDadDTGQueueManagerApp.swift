import SwiftUI

@main
struct BadDadDTGQueueManagerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                QueueView()
            }
            .frame(minWidth: 600, minHeight: 500)
        }
        .windowToolbarStyle(.unified)
        .defaultSize(width: 900, height: 700)
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

        MenuBarExtra("Queue", systemImage: "printer.fill") {
            Button("Open Queue Manager") {
                NSApp.activate(ignoringOtherApps: true)
            }

            Divider()

            Button("Quit") {
                NSApp.terminate(nil)
            }
        }
    }
}
