
import Foundation

//@MainActor
//final class HostsViewModel: ObservableObject {
//    @Published var hosts: [ZabbixHost] = []
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//
//    private let api = ZabbixAPI(
//        baseURL: URL(string: "http://192.168.0.72/zabbix/api_jsonrpc.php")!
//    )
//
//    func load() async {
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            let version = try await api.apiVersion()
//            print("Zabbix version:", version)
//
//            _ = try await api.login(username: "Admin", password: "zabbix")
//            hosts = try await api.fetchHosts()
//        } catch let error as RPCError {
//            errorMessage = error.errorDescription
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//        isLoading = false
//    }
//}


import Foundation

@MainActor
final class HostsViewModel: ObservableObject {
    @Published var hosts: [HostCardModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func load() async {
        isLoading = true
        errorMessage = nil

        try? await Task.sleep(nanoseconds: 500_000_000)

        hosts = MockHostCardData.hosts

        isLoading = false
    }

    func refresh() async {
        await load()
    }
}
