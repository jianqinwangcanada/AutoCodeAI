//
//  ContentView.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionManager:SessionManager
   @State var userName:String=""
   @State var emailName:String=""
    @State var passWord:String=""
    //@State var credentialValid = true
    
    var body: some View {
        VStack {
            
        VStack{
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                TextField("userName", text: $userName).pretty()
                SecureField("passWord",text:$passWord).pretty()
                Button("Login", action: {
                 sessionManager.login(username: userName, password: passWord)
                }).pretty().disabled(userName.isEmpty || passWord.isEmpty)
                if !sessionManager.isCredentialValid{
                    Text("username or password invalid").foregroundColor(Color.red)
               }

            }.padding()

            VStack{
                Spacer()
                //Be careful   sessionmanager.showup() ,while others no ()
                Button("Haven't an account? Sign Up",action:{
                    sessionManager.showSignUp()
                })
                        
                Image(systemName: "trash.square.fill")
                Button("Reset Password?",action:sessionManager.showResetPassword)
            }.padding()
                        
        }
        .padding()
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
