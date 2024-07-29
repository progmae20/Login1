//
//  AppService.swift
//  Login
//
//  Created by Anastasia on 23.07.24.
//

import Appwrite

enum RequestStatus {
    case success
    case error(_ message: String)
}

class AppService {
    
    let client = Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("66a7b2a6003cb81ec06d")
        .setSelfSigned(true)
    
    let account: Account
    
    init() {
        account = Account(client)
    }
    
    func createUser(email: String, password: String) async throws -> RequestStatus {
        do {
            _ = try await account.create(userId: ID.unique(), email: email, password: password)
            return .success
            
        } catch {
            return .error(error.localizedDescription)
        }
    }
    
    func login(email: String, password: String) async throws -> RequestStatus {
        do {
            _ = try await account.createEmailSession(email: email, password: password)
            return .success
            
        } catch {
            return .error(error.localizedDescription)
        }
    }
    
    func logout() async throws -> RequestStatus {
        do {
            _ = try await account.deleteSessions()
            return .success
            
        } catch {
            return .error(error.localizedDescription)
        }
    }

}
