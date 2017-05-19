//
//  SASignIn.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import Parse

class APISignIn : NSObject {
    var username : String?
    var password : String?
    
    init(p_username: String, p_password: String) {
        self.username = p_username
        self.password = p_password
    }
    
    func signUser() throws {
        guard camposVacios() else {
            throw CustomError.campoVacio
        }
        
        guard validarDatosUsuarios() else {
            throw CustomError.campoVacio
        }
    }
    
    func camposVacios() -> Bool {
        return !(username?.isEmpty)! && !(password?.isEmpty)!
    }
    
    func validarDatosUsuarios() -> Bool {
        do {
            try PFUser.logIn(withUsername: username!, password: password!)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return PFUser.current() != nil
    }
}
