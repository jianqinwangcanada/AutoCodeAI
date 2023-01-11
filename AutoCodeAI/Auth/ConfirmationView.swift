//
//  ConfirmationView.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//
//This is the sign up confirmation!!!

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var sessionManager:SessionManager

    @State var confirmationCode=""
    let username:String
    var body: some View {
        VStack{
            Text("UserName:\(username)")
            TextField("Confirmation Code",text: $confirmationCode).pretty()
            Button("Confirm",action: {sessionManager.ConfirmSignUp(username: username, code: confirmationCode)
            }).pretty().disabled(confirmationCode.isEmpty)
        }
    }
    
}
    
    struct ConfirmationView_Previews: PreviewProvider {
        static var previews: some View {
            ConfirmationView( username: "Jamson")
        }
    }

