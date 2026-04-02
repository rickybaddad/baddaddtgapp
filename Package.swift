// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BadDadDTGQueueManager",
    platforms: [
        .macOS(.v13)
    ],
    targets: [
        .executableTarget(
            name: "BadDadDTGQueueManager",
            path: "BadDadDTGQueueManager",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
