//
//  SessionView.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import SwiftUI
import Amplify

struct SessionView: View {
    @EnvironmentObject var sessionManager:SessionManager

    let authUser:AuthUser
    //var user:AuthUser
    var body: some View {
        Spacer()
        Text("You signed as\(authUser.username) using Amplify!! 🥳")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    Spacer()
        Button("Sign Out",action: {sessionManager.signout()})
    }
}

struct SessionView_Previews: PreviewProvider {
    struct dumUser:AuthUser{
        var username  = "David"
        var userId = "1"
    }
    static var previews: some View {
        SessionView(authUser: dumUser())
    }
}
