//
//  ResetPasswordConfirmView.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import SwiftUI

struct ResetPasswordConfirmView: View {
    @EnvironmentObject var sesstionManager:SessionManager
    @State var confirmationCode=""
    @State var password=""
    let username:String
    var body: some View {
        VStack{
            Text("UserName: \(username)")
            TextField("confirmationCode", text: $confirmationCode).pretty()
            SecureField("newpassword",text: $password).pretty()
            Button("Confirm",action: {
                sesstionManager.confirmResetPassword(username: username, newPassword: password, confirmationCode: confirmationCode)
            }).pretty().disabled(confirmationCode.isEmpty||password.isEmpty)
        }.padding()
    }
}

struct ResetPasswordConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordConfirmView(username: "David")
    }
}
