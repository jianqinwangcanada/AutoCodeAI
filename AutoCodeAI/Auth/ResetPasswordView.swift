//
//  ResetPasswordView.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var sessionManager:SessionManager
    @State var userName:String = ""
    var body: some View {
        VStack{
            
            TextField("username", text: $userName).pretty()
            Button("Reset Password", action: {
                sessionManager.resetPassword(username: userName)
            }).pretty().disabled(userName.isEmpty)
        }.padding()
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
