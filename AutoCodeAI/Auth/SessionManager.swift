//
//  SessionManagerView.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import Foundation
import Amplify
enum AuthState{
    case login
    case signup
    case session(user:AuthUser)
    case confirmCode(userName:String)
    case resetConfirmCode(username:String)
    case resetPassword
}

final class SessionManager:ObservableObject{
    @Published var authState:AuthState = .login
    @Published var isCredentialValid = true
    func getCurrentUser(){
        if let user = Amplify.Auth.getCurrentUser(){
            authState = .session(user: user)
        }
        else{
            authState = .login
        }
    }
    
    func showSignUp(){
            authState = .signup
        }
        func showLogin(){
            authState = .login
        }
        func showResetPassword(){
            authState = .resetPassword
        }
    
    func SignUP(userName:String,passWord:String,email:String){
        let attributes = [AuthUserAttribute(.email,value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)
        Amplify.Auth.signUp(username: userName,
                            password: passWord,options: options){[weak self] result in
            switch result{
                case .success(let signUpResult):
                print("Sign up Result:",signUpResult)
                switch signUpResult.nextStep{
                    case .done:
                    print("Sign up successfully")
                case .confirmUser(let details, _):
                    print(details ?? "No details" )
                    DispatchQueue.main.async {
                        self?.authState = .confirmCode(userName: userName)
                    }
                }
                
            case .failure(let error):
                self?.isCredentialValid = false
            print("Failuare sign up",error)
            }
        }
    }
    
    func ConfirmSignUp(username:String,code:String){
           _ = Amplify.Auth.confirmSignUp(for: username, confirmationCode: code){[weak self]result in
               switch result{
               case .success(let confirmReuslt):
                   print(confirmReuslt)
                   if confirmReuslt.isSignupComplete{
                       DispatchQueue.main.async {
                           self?.isCredentialValid = true
                           self?.showLogin()
                       }
                   }
               case .failure(let error):
                   print("Confirm error code,",error)
               }
               
           }
       }
    
    func login(username:String,password:String){
        _ = Amplify.Auth.signIn(
               username: username,
               password: password
           ){[weak self]result in
               switch result{
               case .success(let signinResult):
                   print(signinResult)
                   if signinResult.isSignedIn{
                       DispatchQueue.main.async {
                           self?.getCurrentUser()
                       }
                   }
               case .failure(let error):
                   //Change the isCredentialVAlid
                   self?.isCredentialValid = false
                   print("Login Error",error)
               }
               
               
           }
//        print("Is Valid? \(credentialValid)+++++")
//        return credentialValid
       }
       func signout(){
           _ = Amplify.Auth.signOut{[weak self]result in
               switch result{
               case .success(let signoutResult):
                   print("Sign out",signoutResult)
                   DispatchQueue.main.async {
                       self?.isCredentialValid = true
                       self?.getCurrentUser()
                   }
               case.failure(let error):
                   print("Sign out",error)
               
               }
           }
       }
    func resetPassword(username: String) {
         _ =  Amplify.Auth.resetPassword(for: username) {[weak self] result in
             switch result {
             case .success(let resetPassword):
                
                 switch resetPassword.nextStep{
                 case .confirmResetPasswordWithCode(let deliveryDetails, let info):
                    print("Confirm reset password with code send \(deliveryDetails) \(String(describing: info))")
                     DispatchQueue.main.async {
                         self?.authState = .resetConfirmCode(username: username)
                     }
                case .done:
                    print("Reset completed")
                 }
             case .failure(let resetFailure):
                print("Reset password Failure",resetFailure)
                 
             }
            }
        }
        func confirmResetPassword(
            username: String,
            newPassword: String,
            confirmationCode: String
        ) {
            Amplify.Auth.confirmResetPassword(
                for: username,
                with: newPassword,
                confirmationCode: confirmationCode
            ) {[weak self] result in
                switch result {
                case .success(let confirmResult):
                    print("Password reset confirmed",confirmResult)
                    DispatchQueue.main.async {
                        self?.showLogin()
                    }
                    
                case .failure(let error):
                    print("Reset password failed with error \(error)")
                }
            }
        }
    
    
    
    
    
}

