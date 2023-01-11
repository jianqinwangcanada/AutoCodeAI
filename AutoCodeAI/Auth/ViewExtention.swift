//
//  ViewExtention.swift
//  AutoCodeAI
//
//  Created by Jianqin Wang on 2023-01-09.
//

import Foundation
import SwiftUI

extension TextField{
    func pretty()->some View{
        self.padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40)).border(Color.gray,width: 1).cornerRadius(3)
        //self.padding().border(Color.gray,width: 1).cornerRadius(3)
    }
}
extension SecureField{
    func pretty()->some View{
        self.padding()
        .border(Color.gray,width:1)
        .cornerRadius(3)
        
    }
}
extension Button{
    func pretty()->some View{
        self.padding()
            .background(Color.purple)
            .foregroundColor(Color.white)
            .cornerRadius(3)
    }
}
