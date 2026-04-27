import SwiftUI

struct TopCPUCardView: View {
    let hosts: [DashboardCPUHost]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Топ по CPU")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)

            VStack(spacing: 18) {
                ForEach(hosts) { host in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(AppColors.innerBlockBackground)
                                .frame(width: 42, height: 42)

                            Image(systemName: "server.rack")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.secondary)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(host.name)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.9)

                                Spacer()

                                Text("\(host.cpuLoad)%")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.primary)
                            }

                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(AppColors.progressBackground)
                                        .frame(height: 10)

                                    Capsule()
                                        .fill(barColor(for: host.cpuLoad))
                                        .frame(
                                            width: geo.size.width * CGFloat(host.cpuLoad) / 100,
                                            height: 10
                                        )
                                }
                            }
                            .frame(height: 10)
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(AppColors.separator.opacity(0.25), lineWidth: 1)
        )
    }

    private func barColor(for value: Int) -> Color {
        switch value {
        case 0..<60:
            return .green
        case 60..<85:
            return .orange
        default:
            return .red
        }
    }
}
