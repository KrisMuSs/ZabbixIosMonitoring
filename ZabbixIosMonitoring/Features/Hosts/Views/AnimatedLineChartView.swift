import SwiftUI
import Charts

struct AnimatedLineChartView: View {
    let points: [MetricPoint]
    let color: Color
    let height: CGFloat

    @State private var visiblePoints: [MetricPoint] = []

    var body: some View {
        Chart(visiblePoints) { point in
            LineMark(
                x: .value("Время", point.hour),
                y: .value("Значение", point.value)
            )
            .foregroundStyle(color)
            .lineStyle(StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            .interpolationMethod(.catmullRom)
        }
        .chartYScale(domain: 0...100)
        .frame(height: height)
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        visiblePoints = []

        Task {
            for point in points {
                try? await Task.sleep(for: .milliseconds(90))

                await MainActor.run {
                    withAnimation(.easeOut(duration: 0.18)) {
                        visiblePoints.append(point)
                    }
                }
            }
        }
    }
}

#Preview {
    AnimatedLineChartView(
        points: [
            .init(hour: "1:00", value: 20),
            .init(hour: "3:00", value: 70),
            .init(hour: "5:00", value: 35),
            .init(hour: "7:00", value: 90),
            .init(hour: "9:00", value: 40)
        ],
        color: .blue,
        height: 250
    )
    .padding()
}
