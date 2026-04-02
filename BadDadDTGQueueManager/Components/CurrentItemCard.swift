import SwiftUI

struct CurrentItemCard: View {
    let item: QueueItem?
    let onDone: () -> Void
    let onSkip: () -> Void
    let isPrinting: Bool

    var body: some View {
        ZStack {
            if let item = item {
                ActiveItemView(
                    item: item,
                    onDone: onDone,
                    onSkip: onSkip,
                    isPrinting: isPrinting
                )
            } else {
                EmptyQueueView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.controlBackgroundColor))
    }
}

struct ActiveItemView: View {
    let item: QueueItem
    let onDone: () -> Void
    let onSkip: () -> Void
    let isPrinting: Bool

    var body: some View {
        VStack(spacing: Spacing.xl) {
            Text("CURRENT ITEM")
                .font(.caption)
                .foregroundColor(.secondary)
                .tracking(1.5)

            Text(item.shirtInfo.name)
                .font(.appLargeTitle)
                .multilineTextAlignment(.center)

            HStack(spacing: Spacing.lg) {
                DetailBadge(icon: "ruler", text: item.shirtInfo.size)
                DetailBadge(icon: "paintpalette", text: item.shirtInfo.color)
                DetailBadge(icon: "tshirt.fill", text: item.side.rawValue)
            }

            if item.totalCopies > 1 {
                CopyProgressView(current: item.currentCopy, total: item.totalCopies)
            }

            HStack(spacing: Spacing.md) {
                Button(action: onSkip) {
                    HStack {
                        Image(systemName: "forward.fill")
                        Text("Skip")
                    }
                    .frame(minWidth: 120)
                    .padding(.vertical, Spacing.md)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)

                Button(action: onDone) {
                    HStack {
                        if isPrinting {
                            ProgressView()
                                .controlSize(.small)
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Done")
                        }
                    }
                    .frame(minWidth: 120)
                    .padding(.vertical, Spacing.md)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(isPrinting)
            }
            .font(.title3)
            .padding(.top, Spacing.lg)
        }
        .padding(Spacing.xl)
        .frame(maxWidth: 600)
    }
}

struct DetailBadge: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .foregroundColor(.appPrimary)
            Text(text)
                .fontWeight(.medium)
        }
        .font(.headline)
        .foregroundColor(.secondary)
    }
}

struct CopyProgressView: View {
    let current: Int
    let total: Int

    var progress: Double {
        guard total > 0 else { return 0 }
        return Double(current) / Double(total)
    }

    var body: some View {
        VStack(spacing: Spacing.sm) {
            Text("Copy \(current + 1) of \(total)")
                .font(.title2)
                .fontWeight(.semibold)

            ProgressView(value: progress)
                .progressViewStyle(.linear)
                .tint(.appPrimary)
                .frame(maxWidth: 300)
        }
    }
}

struct EmptyQueueView: View {
    var body: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.appSuccess)

            Text("All Done!")
                .font(.appLargeTitle)

            Text("No items in the queue")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(Spacing.xl)
    }
}
