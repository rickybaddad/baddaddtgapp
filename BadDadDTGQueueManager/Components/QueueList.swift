import SwiftUI

struct QueueList: View {
    let items: [QueueItem]

    var upcomingItems: [QueueItem] {
        items.filter { $0.status == .waiting || $0.status == .ready }
    }

    var completedItems: [QueueItem] {
        items.filter { $0.status == .complete }
    }

    var body: some View {
        List {
            if !upcomingItems.isEmpty {
                Section {
                    ForEach(upcomingItems) { item in
                        UpcomingItemRow(item: item)
                    }
                } header: {
                    SectionHeader(
                        title: "UPCOMING",
                        count: upcomingItems.count,
                        icon: "list.bullet"
                    )
                }
            }

            if !completedItems.isEmpty {
                Section {
                    ForEach(completedItems) { item in
                        CompletedItemRow(item: item)
                    }
                } header: {
                    SectionHeader(
                        title: "COMPLETED",
                        count: completedItems.count,
                        icon: "checkmark.circle"
                    )
                }
            }

            if upcomingItems.isEmpty && completedItems.isEmpty {
                EmptyListView()
            }
        }
        .listStyle(.sidebar)
    }
}

struct SectionHeader: View {
    let title: String
    let count: Int
    let icon: String

    var body: some View {
        HStack {
            Label {
                Text("\(title) (\(count))")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .tracking(1.2)
            } icon: {
                Image(systemName: icon)
                    .font(.caption)
            }
            Spacer()
        }
        .foregroundColor(.secondary)
    }
}

struct UpcomingItemRow: View {
    let item: QueueItem
    @State private var isHovered = false

    var body: some View {
        HStack(spacing: Spacing.md) {
            Circle()
                .fill(item.status.color)
                .frame(width: 8, height: 8)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.shirtInfo.name)
                    .font(.headline)

                HStack(spacing: Spacing.sm) {
                    Text(item.shirtInfo.size)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("•")
                        .foregroundColor(.secondary)
                    Text(item.shirtInfo.color)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("•")
                        .foregroundColor(.secondary)
                    Text(item.side.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            if item.totalCopies > 1 {
                QuantityBadge(count: item.totalCopies)
            }

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
                .opacity(isHovered ? 1 : 0.3)
        }
        .padding(.vertical, Spacing.xs)
        .contentShape(Rectangle())
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.15)) {
                isHovered = hovering
            }
        }
    }
}

struct CompletedItemRow: View {
    let item: QueueItem

    var body: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.appSuccess)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.shirtInfo.name)
                    .font(.headline)

                if let printedAt = item.printedAt {
                    Text(printedAt, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            if item.totalCopies > 1 {
                Text("×\(item.totalCopies)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, Spacing.xs)
        .opacity(0.7)
    }
}

struct QuantityBadge: View {
    let count: Int

    var body: some View {
        Text("×\(count)")
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, 4)
            .background(Color.appPrimary)
            .cornerRadius(AppCornerRadius.small)
    }
}

struct EmptyListView: View {
    var body: some View {
        VStack(spacing: Spacing.md) {
            Image(systemName: "tray")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No items in queue")
                .font(.headline)
                .foregroundColor(.secondary)

            Text("Click a category on your website to load a batch")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Spacing.xl)
    }
}
