//
//  AuthViewController.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//




import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    
    enum AuthState {
        case signUp
        case signIn
    }

    // MARK: - Properties
    private let authView = AuthView()
    private let storageManager = StorageManager()
    private var state: AuthState = .signUp
    
    // MARK: - Lifecycle
    override func loadView() {
        view = authView
        setTextFieldDelegates()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
        print(storageManager.isLoggedIn())
        //print(storageManager.getCurrentUser())
    }

    // MARK: - Setup Methods
    private func setTextFieldDelegates() {
        authView.usernameTextField.delegate = self
        authView.emailTextField.delegate = self
        authView.passwordTextField.delegate = self
        authView.repeatPasswordTextField.delegate = self
    }
    
    private func setupActions() {
        authView.buttonSignUp.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        authView.signInLabelButton.addTarget(self, action: #selector(switchIsTapped), for: .touchUpInside)
    }
}

// MARK: - User Interaction
private extension AuthViewController {
    @objc private func signUpTapped() {
        guard validateInputs() else { return }
        
        if state == .signUp {
            let user = User(
                username: (authView.usernameTextField.text?.lowercased())!,
                email: authView.emailTextField.text?.lowercased() ?? "",
                password: authView.passwordTextField.text ?? ""
            )
            storageManager.clearUserData()
            storageManager.resetOnboarding()
            storageManager.addUser(user)
            storageManager.logIn()
            storageManager.setCurrentUser(user)
            
            let nextVC = CategoriesViewController()
            nextVC.modalPresentationStyle = .custom
            nextVC.transitioningDelegate = self
            present(nextVC, animated: true)
            
        } else {
            logIn()
        }
    }
    
    @objc private func switchIsTapped() {
        if state == .signUp {
            state = .signIn
            authView.state = .signIn
        } else {
            state = .signUp
            authView.state = .signUp
        }
    }
}

// MARK: - Validation Methods
private extension AuthViewController {
    func validateInputs() -> Bool {
        guard let email = authView.emailTextField.text?.lowercased(), !email.isEmpty else {
            authView.showWarningMessage("Please, enter your email.")
            return false
        }
        guard let password = authView.passwordTextField.text, !password.isEmpty else {
            authView.showWarningMessage("Please, enter your password.")
            return false
        }
        if !isValidEmail(email) {
            authView.showWarningMessage("Your email is incorrect.")
            return false
        }
        
        if state == .signUp {
            guard let username = authView.usernameTextField.text?.lowercased(), !username.isEmpty else {
                authView.showWarningMessage("Please, enter your username.")
                return false
            }
            guard let repeatPassword = authView.repeatPasswordTextField.text, repeatPassword == password else {
                authView.showWarningMessage("Your passwords don't match.")
                return false
            }
            if username.count < 3 {
                authView.showWarningMessage("Username must be at least 3 characters.")
                return false
            }
            if password.count < 8 {
                authView.showWarningMessage("Password must be at least 8 characters.")
                return false
            }
            if isEmailTaken(email) {
                authView.showWarningMessage("This email is already registered.")
                return false
            }
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@")
    }
    
    func isEmailTaken(_ email: String) -> Bool {
        let users = storageManager.getUsers()
        return users.contains { $0.email == email }
    }
}

// MARK: - Authentication


private extension AuthViewController {
    
    func logIn() {
        
        guard let email = authView.emailTextField.text?.lowercased(),
              let password = authView.passwordTextField.text else { return }
        
        let users = storageManager.getUsers()
        
        if let matchedUser = users.first(where: { $0.email == email && $0.password == password }) {
            let username = matchedUser.username
            
            let currentUser = User(username: username, email: email, password: password)
            
            storageManager.logIn()
            storageManager.setCurrentUser(currentUser)
            storageManager.setOnboarding()
            
            let nextVC = TabBarController()
            nextVC.modalPresentationStyle = .custom
            nextVC.transitioningDelegate = self
            present(nextVC, animated: true)
        
        } else {
            authView.showWarningMessage("No user found with matching email and password.")
            return
        }
        
 
    }
}


        
 
