//
//  AutoCodeAIApp.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import SwiftUI
import Amplify
import AmplifyPlugins
@main
struct AutoCodeAIApp: App {
    init(){
        configAmplify()
        sessionManager.getCurrentUser()
    }
    @ObservedObject var sessionManager = SessionManager()
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState{
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
            case .signup:
                SignUpView()
                    .environmentObject(sessionManager)
            case .confirmCode(let userName):
                ConfirmationView(username: userName)
                    .environmentObject(sessionManager)
            case .resetPassword:
                ResetPasswordView()
                    .environmentObject(sessionManager)
            case .resetConfirmCode(let userName):
                ResetPasswordConfirmView(username: userName)
                    .environmentObject(sessionManager)
            case .session(let user):
                SessionView(authUser: user)
                    .environmentObject(sessionManager)
            
            }
        }
    }
    func configAmplify(){
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Configuration Successfully!")
        } catch  {
            print("configuration error")
        }
    }
}
