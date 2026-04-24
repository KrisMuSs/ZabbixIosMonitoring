import SwiftUI

struct RecentProblemRowView: View {
    let problem: DashboardRecentProblem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(iconBackgroundColor)
                    .frame(width: 38, height: 38)

                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(iconColor)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(problem.title)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(2)

                Text(problem.hostName)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Text(problem.timeText)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var iconColor: Color {
        switch problem.severity {
        case .critical:
            return .red
        case .high:
            return .orange
        case .warning:
            return .orange
        case .info:
            return .blue
        }
    }

    private var iconBackgroundColor: Color {
        switch problem.severity {
        case .critical:
            return Color.red.opacity(0.14)
        case .high:
            return Color.orange.opacity(0.18)
        case .warning:
            return Color.yellow.opacity(0.28)
        case .info:
            return Color.blue.opacity(0.18)
        }
    }
}
