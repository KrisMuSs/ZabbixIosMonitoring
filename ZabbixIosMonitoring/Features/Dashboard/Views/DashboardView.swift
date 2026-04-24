import SwiftUI
import Charts

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        VStack(spacing: 0) {
            headerSection

            Divider()
                .padding(.top, 12)

            contentSection
        }
        .background(Color(.systemGray6))
        .task {
            await viewModel.load()
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Дашборд")
                .font(.system(size: 28, weight: .bold))

            Text("Общий обзор системы")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView("Загрузка...")
            Spacer()
        } else if let dashboard = viewModel.dashboard {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    summaryCardsSection(dashboard: dashboard)
                    hostsStatusCard(dashboard: dashboard)
                    TopCPUCardView(hosts: dashboard.topCPUHosts)
                    recentProblemsCard(dashboard: dashboard)
                }
                .padding(.horizontal, 12)
                .padding(.top, 14)
                .padding(.bottom, 12)
            }
        }
    }

    private func summaryCardsSection(dashboard: DashboardModel) -> some View {
        HStack(spacing: 10) {
            DashboardStatCardView(
                iconName: "checkmark.circle",
                iconColor: .green,
                iconBackground: Color.green.opacity(0.16),
                value: dashboard.summary.onlineCount,
                title: "Онлайн"
            )

            DashboardStatCardView(
                iconName: "exclamationmark.triangle",
                iconColor: .orange,
                iconBackground: Color.orange.opacity(0.18),
                value: dashboard.summary.problemsCount,
                title: "Проблемы"
            )

            DashboardStatCardView(
                iconName: "xmark.circle",
                iconColor: .red,
                iconBackground: Color.red.opacity(0.14),
                value: dashboard.summary.offlineCount,
                title: "Офлайн"
            )
        }
    }

    private func hostsStatusCard(dashboard: DashboardModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Статус хостов")
                .font(.system(size: 18, weight: .bold))

            Chart {
                SectorMark(
                    angle: .value("Онлайн", dashboard.summary.onlineCount),
                    innerRadius: .ratio(0.62),
                    angularInset: 3
                )
                .foregroundStyle(Color.green)

                SectorMark(
                    angle: .value("Проблемы", dashboard.summary.problemsCount),
                    innerRadius: .ratio(0.62),
                    angularInset: 3
                )
                .foregroundStyle(Color.orange)

                SectorMark(
                    angle: .value("Офлайн", dashboard.summary.offlineCount),
                    innerRadius: .ratio(0.62),
                    angularInset: 3
                )
                .foregroundStyle(Color.red)
            }
            .frame(height: 220)

            VStack(alignment: .leading, spacing: 10) {
                legendItem(color: .green, text: "Онлайн: \(dashboard.summary.onlineCount)")
                legendItem(color: .orange, text: "Проблемы: \(dashboard.summary.problemsCount)")
                legendItem(color: .red, text: "Офлайн: \(dashboard.summary.offlineCount)")
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.gray.opacity(0.12), lineWidth: 1)
        )
    }

    private func legendItem(color: Color, text: String) -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)

            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
    }

    private func recentProblemsCard(dashboard: DashboardModel) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Последние проблемы")
                    .font(.system(size: 18, weight: .bold))

                Spacer()

                Text("Все")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
            }

            VStack(spacing: 12) {
                ForEach(dashboard.recentProblems) { problem in
                    RecentProblemRowView(problem: problem)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.gray.opacity(0.12), lineWidth: 1)
        )
    }
}

#Preview {
    DashboardView()
}
