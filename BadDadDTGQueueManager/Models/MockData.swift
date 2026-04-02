import Foundation

class MockData {
    static let sampleItems: [QueueItem] = [
        QueueItem(
            id: UUID(),
            batchName: "Print Black Front Shirts",
            shirtInfo: ShirtInfo(name: "Beard Banner", size: "XL", color: "Black"),
            side: .front,
            currentCopy: 1,
            totalCopies: 2,
            status: .ready,
            addedAt: Date(),
            printedAt: nil
        ),
        QueueItem(
            id: UUID(),
            batchName: "Print Black Front Shirts",
            shirtInfo: ShirtInfo(name: "Staple Beard", size: "Large", color: "Black"),
            side: .front,
            currentCopy: 0,
            totalCopies: 1,
            status: .waiting,
            addedAt: Date(),
            printedAt: nil
        ),
        QueueItem(
            id: UUID(),
            batchName: "Print Black Front Shirts",
            shirtInfo: ShirtInfo(name: "Simple Dad", size: "XL", color: "Black"),
            side: .front,
            currentCopy: 0,
            totalCopies: 3,
            status: .waiting,
            addedAt: Date(),
            printedAt: nil
        ),
        QueueItem(
            id: UUID(),
            batchName: "Print Black Front Shirts",
            shirtInfo: ShirtInfo(name: "Mountain Logo", size: "Medium", color: "Black"),
            side: .front,
            currentCopy: 1,
            totalCopies: 1,
            status: .complete,
            addedAt: Date().addingTimeInterval(-3600),
            printedAt: Date().addingTimeInterval(-300)
        ),
        QueueItem(
            id: UUID(),
            batchName: "Print Black Front Shirts",
            shirtInfo: ShirtInfo(name: "Classic Badge", size: "Large", color: "Black"),
            side: .front,
            currentCopy: 1,
            totalCopies: 1,
            status: .complete,
            addedAt: Date().addingTimeInterval(-3700),
            printedAt: Date().addingTimeInterval(-400)
        )
    ]
}
