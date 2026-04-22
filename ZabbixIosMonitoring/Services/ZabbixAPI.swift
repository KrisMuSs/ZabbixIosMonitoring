import Foundation

final class ZabbixAPI {
    private let baseURL: URL
    private var authToken: String?

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func login(username: String, password: String) async throws -> String {
        let params = UserLoginParams(username: username, password: password)
        let request = JSONRPCRequest(
            method: "user.login",
            params: params,
            id: 1
        )

        let response: JSONRPCResponse<String> = try await send(request)

        print("LOGIN RESPONSE RESULT:", response.result ?? "nil")
        print("LOGIN RESPONSE ERROR:", response.error?.errorDescription ?? "nil")

        if let error = response.error {
            throw error
        }

        guard let token = response.result else {
            throw URLError(.badServerResponse)
        }

        self.authToken = token
        return token
    }

    func fetchHosts() async throws -> [ZabbixHost] {
        guard authToken != nil else {
            throw URLError(.userAuthenticationRequired)
        }

        let params = HostGetParams(
            output: ["hostid", "host", "name"],
            selectInterfaces: ["interfaceid", "ip", "port", "available"]
        )

        let request = JSONRPCRequest(
            method: "host.get",
            params: params,
            id: 2
        )

        let response: JSONRPCResponse<[ZabbixHost]> = try await send(request)

        if let error = response.error {
            throw error
        }

        return response.result ?? []
    }

    func apiVersion() async throws -> String {
        struct EmptyParams: Encodable {}

        let request = JSONRPCRequest(
            method: "apiinfo.version",
            params: EmptyParams(),
            id: 0
        )

        let response: JSONRPCResponse<String> = try await send(request)

        if let error = response.error {
            throw error
        }

        guard let result = response.result else {
            throw URLError(.badServerResponse)
        }

        return result
    }

    private func send<P: Encodable, R: Decodable>(_ payload: JSONRPCRequest<P>) async throws -> JSONRPCResponse<R> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        request.setValue("application/json-rpc", forHTTPHeaderField: "Content-Type")

        if let authToken {
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }

        request.httpBody = try JSONEncoder().encode(payload)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("STATUS:", httpResponse.statusCode)
        print("BODY:", String(data: data, encoding: .utf8) ?? "empty")

        guard 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(JSONRPCResponse<R>.self, from: data)
    }
}
