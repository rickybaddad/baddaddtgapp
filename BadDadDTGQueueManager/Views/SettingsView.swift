import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }

            AutomationSettingsView()
                .tabItem {
                    Label("Automation", systemImage: "bolt.fill")
                }

            AboutSettingsView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .frame(width: 500, height: 400)
    }
}

struct GeneralSettingsView: View {
    @State private var autoProcess = true
    @State private var delayBetweenJobs = 5.0

    var body: some View {
        Form {
            Section(header: Text("Queue Processing")) {
                Toggle("Auto-process queue", isOn: $autoProcess)

                HStack {
                    Text("Delay between jobs:")
                    TextField("Seconds", value: $delayBetweenJobs, format: .number)
                        .frame(width: 60)
                    Text("seconds")
                }
            }
        }
        .padding()
    }
}

struct AutomationSettingsView: View {
    @State private var closeFileViewer = true

    var body: some View {
        Form {
            Section(header: Text("GTX File Viewer")) {
                Toggle("Close File Viewer after sending", isOn: $closeFileViewer)
            }

            Section(header: Text("Status")) {
                HStack {
                    Text("Accessibility Permission")
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text("Not Granted")
                        .foregroundColor(.secondary)
                }

                Button("Open System Preferences") {
                    // Will implement later
                }
            }
        }
        .padding()
    }
}

struct AboutSettingsView: View {
    var body: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "printer.fill")
                .font(.system(size: 64))
                .foregroundColor(.appPrimary)

            Text("BadDadDTG Queue Manager")
                .font(.title)
                .fontWeight(.bold)

            Text("Version 1.0.0")
                .foregroundColor(.secondary)

            Text("© 2026 BadDad Clothing")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, Spacing.lg)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
