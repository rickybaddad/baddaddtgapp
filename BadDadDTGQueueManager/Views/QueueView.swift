import SwiftUI

struct QueueView: View {
    @State private var items = MockData.sampleItems
    @State private var isPrinting = false
    @State private var batchName = "Print Black Front Shirts"

    var currentItem: QueueItem? {
        items.first { $0.status == .ready }
    }

    var completedItems: [QueueItem] {
        items.filter { $0.status == .complete }
    }

    var body: some View {
        VStack(spacing: 0) {
            CurrentItemCard(
                item: currentItem,
                onDone: handleDone,
                onSkip: handleSkip,
                isPrinting: isPrinting
            )
            .frame(maxHeight: .infinity)

            Divider()

            QueueList(items: items)
                .frame(height: 300)
        }
        .navigationTitle(batchName)
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Spacer()

                Button(action: clearCompleted) {
                    Label("Clear Completed", systemImage: "trash")
                }
                .disabled(completedItems.isEmpty)
            }
        }
    }

    func handleDone() {
        isPrinting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isPrinting = false
        }
    }

    func handleSkip() {
        // Placeholder
    }

    func clearCompleted() {
        withAnimation {
            items.removeAll { $0.status == .complete }
        }
    }
}
