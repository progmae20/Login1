//
//  LoginApp.swift
//  Login
//
//  Created by Anastasia on 24.07.24.
//

import SwiftUI

@main
struct LoginSignupApp: App {
    @StateObject private var viewModel = ViewModel(service: AppService())
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(viewModel)
        }
    }
}
