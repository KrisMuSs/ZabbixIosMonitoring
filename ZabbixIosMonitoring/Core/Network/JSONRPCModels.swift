
import Foundation

struct JSONRPCRequest<P: Encodable>: Encodable {
    let jsonrpc = "2.0"
    let method: String
    let params: P
    let id: Int
}

struct JSONRPCResponse<R: Decodable>: Decodable {
    let jsonrpc: String
    let result: R?
    let error: RPCError?
    let id: Int
}

struct RPCError: Decodable, Error, LocalizedError {
    let code: Int
    let message: String
    let data: String?

    var errorDescription: String? {
        if let data, !data.isEmpty {
            return "Ошибка API \(code): \(message)\n\(data)"
        } else {
            return "Ошибка API \(code): \(message)"
        }
    }
}
