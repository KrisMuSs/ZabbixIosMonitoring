import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var serverURL = "http://192.168.0.72/zabbix/"
    @Published var username = "admin"
    @Published var password = ""
    
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    @Published var isAuthenticated = false
    
    func login() {
        guard !serverURL.isEmpty, !username.isEmpty, !password.isEmpty else {
            errorMessage = "Пожалуйста, заполните все поля"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            if username == "Admin" && password == "zabbix" {
                isAuthenticated = true
            } else {
                errorMessage = "Неверный логин или пароль (Мок: Admin / zabbix)"
            }
            
            isLoading = false
        }
    }
}
