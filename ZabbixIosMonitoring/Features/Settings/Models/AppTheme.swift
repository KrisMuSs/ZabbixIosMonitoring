import Foundation

enum AppTheme: String, CaseIterable, Identifiable {
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .light:
            return "Светлая"
        case .dark:
            return "Тёмная"
        }
    }
}
