
import Foundation

struct UserLoginParams: Encodable {
    let username: String
    let password: String
}

struct HostGetParams: Encodable {
    let output: [String]
    let selectInterfaces: [String]
}

struct ZabbixHost: Decodable, Identifiable {
    let hostid: String
    let host: String
    let name: String
    let interfaces: [HostInterface]?
    
    var id: String { hostid }
}

struct HostInterface: Decodable {
    let interfaceid: String?
    let ip: String?
    let port: String?
    let available: String?
}
