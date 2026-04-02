import SwiftUI

extension Color {
    static let appPrimary = Color.blue
    static let appSuccess = Color.green
    static let appWarning = Color.orange
    static let appError = Color.red
}

extension Font {
    static let appLargeTitle = Font.largeTitle.weight(.bold)
    static let appTitle = Font.title.weight(.semibold)
    static let appHeadline = Font.headline
}

struct Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}

struct AppCornerRadius {
    static let small: CGFloat = 6
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
}
