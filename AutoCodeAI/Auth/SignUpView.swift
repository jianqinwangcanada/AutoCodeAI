//
//  SignUpView.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var sessionManager:SessionManager
    @State var userName:String = ""
    @State var email = ""
    @State var passWord = ""
    var body: some View {
       
        VStack{
            //Spacer()

            TextField("username",text:$userName).pretty()
            TextField("email", text: $email).pretty()
            SecureField("password", text: $passWord).pretty()
            Button("Sign Up", action: {
                sessionManager.SignUP(userName: userName, passWord: passWord, email: email)
            }).pretty().disabled(userName.isEmpty || passWord.isEmpty)
            Button("Already Has an account? Log in",action:{sessionManager.showLogin()})
        }.padding()
       
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
