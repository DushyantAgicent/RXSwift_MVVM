//
//  LoginModel.swift
//  RxSwiftMVVM
//
//  Created by Dushyant Varshney on 26/03/21.
//

import Foundation

class LoginModel{
    
    var email = ""
    var password = ""
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
