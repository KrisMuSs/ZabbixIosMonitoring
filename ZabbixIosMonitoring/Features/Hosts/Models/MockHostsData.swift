import Foundation

enum MockHostsData {
    static let hosts: [ZabbixHost] = [
        ZabbixHost(
            hostid: "10101",
            host: "web-server-01",
            name: "Web Server 01",
            interfaces: [
                HostInterface(
                    interfaceid: "1",
                    ip: "192.168.0.101",
                    port: "10050",
                    available: "1"
                )
            ]
        ),
        ZabbixHost(
            hostid: "10102",
            host: "db-server-01",
            name: "Database Server 01",
            interfaces: [
                HostInterface(
                    interfaceid: "2",
                    ip: "192.168.0.102",
                    port: "10050",
                    available: "1"
                )
            ]
        ),
        ZabbixHost(
            hostid: "10103",
            host: "docker-node-01",
            name: "Docker Node 01",
            interfaces: [
                HostInterface(
                    interfaceid: "3",
                    ip: "192.168.0.103",
                    port: "10050",
                    available: "0"
                )
            ]
        ),
        ZabbixHost(
            hostid: "10104",
            host: "worker-vm-01",
            name: "Worker VM 01",
            interfaces: [
                HostInterface(
                    interfaceid: "4",
                    ip: "192.168.0.104",
                    port: "10050",
                    available: "1"
                )
            ]
        ),
        ZabbixHost(
            hostid: "10105",
            host: "test-host-01",
            name: "Test Host 01",
            interfaces: [
                HostInterface(
                    interfaceid: "5",
                    ip: "192.168.0.105",
                    port: "10050",
                    available: "2"
                )
            ]
        )
    ]
}
