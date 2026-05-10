import SwiftUI
import Charts

struct HostDetailsView: View {
    let host: HostCardModel
    @Environment(\.dismiss) private var dismiss

    private var details: HostDetailsModel {
        MockHostDetailsData.details(for: host)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                currentMetricsCard

                if !details.cpuHistory.isEmpty {
                    chartCard(
                        title: "CPU (24ч)",
                        points: details.cpuHistory,
                        color: .blue
                    )
                }

                if !details.ramHistory.isEmpty {
                    chartCard(
                        title: "Память (24ч)",
                        points: details.ramHistory,
                        color: .purple
                    )
                }

                if !details.diskHistory.isEmpty {
                    chartCard(
                        title: "Диск (24ч)",
                        points: details.diskHistory,
                        color: .green
                    )
                }

                problemsCard
            }
            .padding(.horizontal, 16)
            .padding(.top, 18)
            .padding(.bottom, 24)
        }
        .background(AppColors.screenBackground)
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top) {
            headerView
                .background(AppColors.cardBackground)
                .overlay(alignment: .bottom) {
                    Divider()
                }
        }
    }

    private var headerView: some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                dismiss()
            } label: {
                ZStack {
                    Circle()
                        .fill(AppColors.innerBlockBackground)
                        .frame(width: 48, height: 48)

                    Image(systemName: "arrow.left")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                }
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(details.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                Text(details.ipAddress)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Circle()
                .fill(statusColor)
                .frame(width: 22, height: 22)
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 14)
    }

    private var currentMetricsCard: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text("Текущие показатели")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)

            HStack(spacing: 20) {
                summaryMetric(title: "CPU", value: details.cpuLoad)
                summaryMetric(title: "RAM", value: details.ramLoad)
                summaryMetric(title: "Disk", value: details.diskLoad)
            }
        }
        .padding(20)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(AppColors.separator.opacity(0.25), lineWidth: 1)
        )
    }

    private func summaryMetric(title: String, value: Int) -> some View {
        VStack(spacing: 10) {
            Text("\(value)%")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.primary)

            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(AppColors.progressBackground)
                        .frame(height: 14)

                    Capsule()
                        .fill(metricColor(for: value))
                        .frame(
                            width: max(0, geo.size.width * CGFloat(value) / 100),
                            height: 14
                        )
                }
            }
            .frame(height: 14)
        }
        .frame(maxWidth: .infinity)
    }

    private func chartCard(title: String, points: [MetricPoint], color: Color) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)

            AnimatedLineChartView(
                points: points,
                color: color,
                height: 250
            )
        }
        .padding(20)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(AppColors.separator.opacity(0.25), lineWidth: 1)
        )
    }

    private var problemsCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Активные проблемы")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)

            if details.activeProblems.isEmpty {
                HStack {
                    Spacer()

                    Text("Проблем не обнаружено")
                        .font(.system(size: 17))
                        .foregroundColor(.secondary)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 112)
                .background(AppColors.innerBlockBackground)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            } else {
                VStack(spacing: 12) {
                    ForEach(details.activeProblems) { problem in
                        problemRow(problem)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(AppColors.separator.opacity(0.25), lineWidth: 1)
        )
    }

    private func problemRow(_ problem: HostProblem) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(problemIconBackground(problem.severity))
                    .frame(width: 44, height: 44)

                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(problemIconColor(problem.severity))
                    .font(.system(size: 20, weight: .medium))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(problem.title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)

                Text(problem.subtitle)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(AppColors.innerBlockBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private var statusColor: Color {
        switch details.status {
        case .online:
            return .green
        case .warning:
            return .orange
        case .offline:
            return .red
        }
    }

    private func metricColor(for value: Int) -> Color {
        switch value {
        case 0..<60:
            return .green
        case 60..<85:
            return .orange
        default:
            return .red
        }
    }

    private func problemIconColor(_ severity: ProblemSeverity) -> Color {
        switch severity {
        case .warning:
            return .orange
        case .critical:
            return .red
        }
    }

    private func problemIconBackground(_ severity: ProblemSeverity) -> Color {
        switch severity {
        case .warning:
            return Color.orange.opacity(0.18)
        case .critical:
            return Color.red.opacity(0.14)
        }
    }
}

#Preview("Light") {
    HostDetailsView(host: MockHostCardData.hosts[0])
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    HostDetailsView(host: MockHostCardData.hosts[0])
        .preferredColorScheme(.dark)
}
