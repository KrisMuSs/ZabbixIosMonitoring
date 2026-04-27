import SwiftUI

struct DashboardStatCardView: View {
    let iconName: String
    let iconColor: Color
    let iconBackground: Color
    let value: Int
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(iconBackground)
                    .frame(width: 50, height: 50)

                Image(systemName: iconName)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(iconColor)
            }

            Text("\(value)")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.primary)

            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
                .lineLimit(2)
                .minimumScaleFactor(0.9)
        }
        .frame(maxWidth: .infinity, minHeight: 138, alignment: .topLeading)
        .padding(18)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(AppColors.separator.opacity(0.25), lineWidth: 1)
        )
    }
}
