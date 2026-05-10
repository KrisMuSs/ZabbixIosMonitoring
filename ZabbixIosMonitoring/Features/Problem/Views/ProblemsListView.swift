import SwiftUI

struct ProblemsListView: View {
    @StateObject private var viewModel = ProblemsViewModel()

    var body: some View {
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
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 22) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Проблемы")
                    .font(.system(size: 30, weight: .bold))

                Text(viewModel.alertsCountText)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
            }

            HStack(spacing: 10) {
                ForEach(ProblemsFilter.allCases) { filter in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.selectedFilter = filter
                        }
                    } label: {
                        Text(filter.rawValue)
                            .font(.system(size: 16, weight: viewModel.selectedFilter == filter ? .semibold : .medium))
                            .foregroundColor(viewModel.selectedFilter == filter ? .primary : .secondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                viewModel.selectedFilter == filter
                                ? AppColors.cardBackground
                                : Color.clear
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                }
            }
            .padding(8)
            .background(AppColors.innerBlockBackground)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
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
        } else {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.filteredProblems) { problem in
                        ProblemCardView(problem: problem)
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
    ProblemsListView()
}
