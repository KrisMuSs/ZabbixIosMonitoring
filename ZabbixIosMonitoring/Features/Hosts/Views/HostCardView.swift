import SwiftUI

struct HostCardView: View {
    let host: HostCardModel

    var body: some View {
        VStack(spacing: 18) {
            HStack(alignment: .top, spacing: 14) {
                statusIcon
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Text(host.name)
                            .font(.system(size: 20, weight: .semibold))

                        Circle()
                            .fill(statusColor)
                            .frame(width: 16, height: 16)
                    }

                    Text(host.ipAddress)
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding(.top, 6)
            }

            HStack(spacing: 18) {
                MetricBarView(title: "CPU", value: host.cpuLoad)
                MetricBarView(title: "RAM", value: host.ramLoad)
                MetricBarView(title: "DISK", value: host.diskLoad)
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.gray.opacity(0.12), lineWidth: 1)
        )
    }

    private var statusIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(iconBackgroundColor)
                .frame(width: 72, height: 72)

            Image(systemName: "server.rack")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(iconTintColor)
        }
    }

    private var statusColor: Color {
        switch host.status {
        case .online:
            return .green
        case .warning:
            return .orange
        case .offline:
            return .red
        }
    }

    private var iconBackgroundColor: Color {
        switch host.status {
        case .online:
            return Color.green.opacity(0.18)
        case .warning:
            return Color.orange.opacity(0.22)
        case .offline:
            return Color.red.opacity(0.16)
        }
    }

    private var iconTintColor: Color {
        switch host.status {
        case .online:
            return Color.green
        case .warning:
            return Color.orange
        case .offline:
            return Color.red
        }
    }
}

private struct MetricBarView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.secondary)

                Spacer()

                Text("\(value)%")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.18))
                        .frame(height: 14)

                    Capsule()
                        .fill(barColor)
                        .frame(
                            width: max(14, geo.size.width * CGFloat(value) / 100),
                            height: 14
                        )
                }
            }
            .frame(height: 14)
        }
    }

    private var barColor: Color {
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
