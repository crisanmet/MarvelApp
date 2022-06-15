//
//  LoginViewController.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 13/06/2022.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    lazy var emailTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.textColor = .black
        textField.keyboardType = .emailAddress
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(40)
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(40)
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.gray , for: .normal)
        button.backgroundColor = UIColor(named: "ColorLoginFalse")?.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.gray , for: .normal)
        button.backgroundColor = UIColor(named: "ColorLoginFalse")?.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don´t have an account? Sing Up.", for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

        setupUI()
    }
    

    //MARK: - Helpers
    
    private func setupUI(){
        view.backgroundColor = .lightGray.withAlphaComponent(0.7)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, signupButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else {
            viewModel.password = sender.text
        }
        
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
        
        signupButton.backgroundColor = viewModel.buttonBackgroundColor
        signupButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signupButton.isEnabled = viewModel.formIsValid
    }
    
    @objc func handleLogin(){
        viewModel.loginUser()
        
    }

    @objc func handleShowSignUp(){
    }
    
    @objc func handleSignup(){
        viewModel.createUser()
    }
    
    func showMessageError(message: String){
            let alert = UIAlertController(title: "Fail", message: message, preferredStyle: .alert)
    
            let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
            
            alert.addAction(actionCancel)
            
            present(alert, animated: true)
        }

}


//MARK: - Login Delegate

extension LoginViewController: LoginDelegate{
    func didFailLoginUser(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showMessageError(message: error)
        }
        
    }
    
    func didSuccessLoginUser() {
        DispatchQueue.main.async { [weak self] in
            let MainTabBarVC = TabBarViewController()
            self?.navigationController?.pushViewController(MainTabBarVC, animated: true)
        }
    }
    
    
}

//MARK: - Textfield Delegate

extension LoginViewController: UITextFieldDelegate{
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
       return true
    }
}
