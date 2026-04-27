import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @AppStorage("selected_app_theme") private var storedTheme: String = AppTheme.light.rawValue

    private var selectedTheme: AppTheme {
        AppTheme(rawValue: storedTheme) ?? .light
    }

    private func toggleTheme() {
        let currentTheme = AppTheme(rawValue: storedTheme) ?? .light

        storedTheme = currentTheme == .light
            ? AppTheme.dark.rawValue
            : AppTheme.light.rawValue
    }

    var body: some View {
        VStack(spacing: 0) {
            headerSection

            Divider()
                .padding(.top, 14)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {
                    appearanceSection
                    connectionSection
                    actionsSection
                    footerSection
                }
                .padding(.top, 18)
                .padding(.bottom, 24)
            }
        }
        .background(AppColors.screenBackground)
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Настройки")
                .font(.system(size: 30, weight: .bold))

            Text("Управление приложением")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }

    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("ВНЕШНИЙ ВИД")

            ThemeSettingsRow(
                selectedTheme: selectedTheme,
                onTap: {
                    toggleTheme()
                }
            )
        }
        .padding(.horizontal, 16)
    }
    private struct ThemeSettingsRow: View {
        let selectedTheme: AppTheme
        let onTap: () -> Void

        private var iconName: String {
            selectedTheme == .light ? "sun.max" : "moon"
        }

        private var iconColor: Color {
            selectedTheme == .light ? .orange : .blue
        }

        private var iconBackgroundColor: Color {
            selectedTheme == .light
                ? Color.orange.opacity(0.18)
                : Color.blue.opacity(0.18)
        }

        var body: some View {
            Button {
                onTap()
            } label: {
                HStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(iconBackgroundColor)
                            .frame(width: 62, height: 62)

                        Image(systemName: iconName)
                            .font(.system(size: 28, weight: .medium))
                            .foregroundColor(iconColor)
                    }

                    Text("Тема")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)

                    Spacer()

                    Text(selectedTheme.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.secondary)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .padding(20)
                .background(AppColors.cardBackground)                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(AppColors.separator.opacity(0.25), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
    }
    private var connectionSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("ПОДКЛЮЧЕНИЕ")

            VStack(spacing: 0) {
                settingsInfoRow(
                    iconName: "server.rack",
                    title: "URL сервера",
                    value: viewModel.serverURL
                )

                dividerLine()

                settingsInfoRow(
                    iconName: "person",
                    title: "Логин",
                    value: viewModel.login
                )

                dividerLine()

                settingsInfoRow(
                    iconName: "lock",
                    title: "Пароль",
                    value: viewModel.password
                )
            }
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(Color.gray.opacity(0.12), lineWidth: 1)
            )
        }
        .padding(.horizontal, 16)
    }

    private var actionsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("ДЕЙСТВИЯ")

            Button {} label: {
                HStack(spacing: 16) {
                    settingsIcon(
                        systemName: "arrow.right",
                        iconColor: .red,
                        backgroundColor: Color.red.opacity(0.14)
                    )

                    Text("Выйти")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.red)

                    Spacer()
                }
                .padding(20)
                .background(AppColors.cardBackground)                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.gray.opacity(0.12), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
    }

    private var footerSection: some View {
        VStack(spacing: 10) {
            Text("Zabbix Monitor")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.secondary)

            Text(viewModel.appVersionText)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.secondary)
            .padding(.horizontal, 4)
    }

    private func settingsIcon(systemName: String, iconColor: Color, backgroundColor: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(backgroundColor)
                .frame(width: 62, height: 62)

            Image(systemName: systemName)
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(iconColor)
        }
    }

    private func settingsInfoRow(iconName: String, title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(AppColors.innerBlockBackground)
                    .frame(width: 62, height: 62)

                Image(systemName: iconName)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)

                Text(value)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }

            Spacer()
        }
        .padding(20)
    }

    private func dividerLine() -> some View {
        Divider()
            .padding(.leading, 98)
    }
}

#Preview {
    SettingsView()
}
