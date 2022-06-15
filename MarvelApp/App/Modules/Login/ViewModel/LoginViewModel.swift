//
//  LoginViewModel.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 13/06/2022.
//

import UIKit
import FirebaseAuth

protocol LoginDelegate: AnyObject {
    func didFailLoginUser(error: String)
    func didSuccessLoginUser()
}

class LoginViewModel {
    
    weak var delegate: LoginDelegate?
    
    var email: String?
    var password: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(named: "ColorLogin")! : UIColor(named: "ColorLoginFalse")!.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  
    }
    
    func createUser(){
        guard let email = email, let password = password else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                self.delegate?.didFailLoginUser(error: ApiError.failSignup.errorDescription!)
                return
            }else {
                self.delegate?.didSuccessLoginUser()
            }
        }
    }
    
    func loginUser(){
        guard let email = email, let password = password else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.delegate?.didFailLoginUser(error: ApiError.failLogin.errorDescription!)
                return
            }else {
                self.delegate?.didSuccessLoginUser()
            }
        }
    }
}
