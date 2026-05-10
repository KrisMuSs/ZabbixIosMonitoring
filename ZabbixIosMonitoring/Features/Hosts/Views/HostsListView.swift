import SwiftUI

struct HostsListView: View {
    @StateObject private var viewModel = HostsViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection

                Divider()
                    .padding(.top, 16)

                contentSection
            }
            .background(AppColors.screenBackground)
            .task {
                await viewModel.load()
            }
            .navigationDestination(for: HostCardModel.self) { host in
                HostDetailsView(host: host)
            }
        }
    }

    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Хосты")
                    .font(.system(size: 30, weight: .bold))

                Text("\(viewModel.hosts.count) серверов")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button {
                Task {
                    await viewModel.refresh()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(AppColors.innerBlockBackground)
                        .frame(width: 54, height: 54)

                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView("Загрузка...")
            Spacer()
        } else if let errorMessage = viewModel.errorMessage {
            Spacer()
            VStack(spacing: 12) {
                Text("Ошибка")
                    .font(.title2)

                Text(errorMessage)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
            }
            .padding()
            Spacer()
        } else {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.hosts) { host in
                        NavigationLink(value: host) {
                            HostCardView(host: host)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 18)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    HostsListView()
}
