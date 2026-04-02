import SwiftUI

struct QueueItem: Identifiable {
    let id: UUID
    let batchName: String
    let shirtInfo: ShirtInfo
    let side: DesignSide
    var currentCopy: Int
    let totalCopies: Int
    var status: JobStatus
    let addedAt: Date
    var printedAt: Date?

    var displayName: String {
        "\(shirtInfo.name) - \(shirtInfo.size)"
    }

    var progressPercentage: Double {
        guard totalCopies > 0 else { return 0 }
        return Double(currentCopy) / Double(totalCopies)
    }
}

struct ShirtInfo {
    let name: String
    let size: String
    let color: String
}

enum DesignSide: String {
    case front = "Front"
    case back = "Back"
}

enum JobStatus: String {
    case waiting = "Waiting"
    case ready = "Ready"
    case printing = "Printing"
    case printed = "Printed"
    case complete = "Complete"
    case skipped = "Skipped"
    case error = "Error"

    var color: Color {
        switch self {
        case .waiting: return .gray
        case .ready: return .blue
        case .printing: return .orange
        case .printed, .complete: return .green
        case .skipped: return .secondary
        case .error: return .red
        }
    }

    var icon: String {
        switch self {
        case .waiting: return "clock"
        case .ready: return "circle.fill"
        case .printing: return "arrow.triangle.2.circlepath"
        case .printed, .complete: return "checkmark.circle.fill"
        case .skipped: return "forward.fill"
        case .error: return "exclamationmark.triangle.fill"
        }
    }
}
