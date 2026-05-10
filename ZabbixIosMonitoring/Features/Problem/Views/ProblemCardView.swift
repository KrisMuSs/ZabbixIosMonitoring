import SwiftUI

struct ProblemCardView: View {
    let problem: ProblemModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 18) {
                ZStack {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(iconBackgroundColor)
                        .frame(width: 78, height: 78)

                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundColor(iconColor)
                }

                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        Text(problem.title)
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundColor(.primary)

                        Spacer()

                        if problem.status == .resolved {
                            Text("Решено")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.green)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.green.opacity(0.16))
                                .clipShape(Capsule())
                        }
                    }

                    Text("\(problem.hostName)  •  \(problem.timeText)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }

            Text(problem.severity.rawValue)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(severityTextColor)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(severityBackgroundColor)
                .clipShape(Capsule())
        }
        .padding(24)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                // Заменяем фиксированный серый на системный разделитель
                .stroke(AppColors.separator.opacity(0.25), lineWidth: 1)
        )
    }

    private var iconColor: Color {
        switch problem.severity {
        case .critical: return .red
        case .high: return Color.orange
        case .warning: return Color.orange
        case .info: return Color.blue
        }
    }

    private var iconBackgroundColor: Color {
        switch problem.severity {
        case .critical: return Color.red.opacity(0.14)
        case .high: return Color.orange.opacity(0.18)
        case .warning: return Color.yellow.opacity(0.28)
        case .info: return Color.blue.opacity(0.18)
        }
    }

    private var severityTextColor: Color {
        switch problem.severity {
        case .critical: return .red
        case .high: return Color.orange
        case .warning: return Color.orange
        case .info: return Color.blue
        }
    }

    private var severityBackgroundColor: Color {
        switch problem.severity {
        case .critical: return Color.red.opacity(0.12)
        case .high: return Color.orange.opacity(0.16)
        case .warning: return Color.yellow.opacity(0.28)
        case .info: return Color.blue.opacity(0.16)
        }
    }
}

#Preview {
    ProblemCardView(problem: MockProblemsData.problems[0])
        .padding()
        .background(Color(.systemGray6))
}
