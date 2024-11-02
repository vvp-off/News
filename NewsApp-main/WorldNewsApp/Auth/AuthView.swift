//
//  AuthView.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//

import UIKit

class AuthView: UIView {

    //MARK: - Properties
    enum AuthState {
        case signUp
        case signIn
    }

    var state: AuthState = .signUp {
            didSet {
                updateConstraintsForState()
                updateForState(state)
            }
    }

    var emailTopConstraint: NSLayoutConstraint!
    var usernameHeightConstraint: NSLayoutConstraint!
    var repeatPasswordHeightConstraint: NSLayoutConstraint!


    let headerLabel = UILabel.makeHeaderLabel(with: "Welcome to NewsToDay")
    let subHeaderLabel = UILabel.makeSubheaderLabel(with: "Hello, I guess you're new around here. You can start using the app after sign up.")

    let usernameTextField = UITextField.makeCustomTextfield(placeholderText: "Username", iconName: "person", isSecure: false, keyboardType: .default)

    let emailTextField = UITextField.makeCustomTextfield(placeholderText: "Email", iconName: "envelope", isSecure: false, keyboardType: .emailAddress)

    let passwordTextField = UITextField.makeCustomTextfield(placeholderText: "Password", iconName: "lock", isSecure: true, keyboardType: .numberPad)

    let repeatPasswordTextField = UITextField.makeCustomTextfield(placeholderText: "Repeat Password", iconName: "lock", isSecure: true, keyboardType: .numberPad)

    let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = AppColors.purpleDark
        label.font = UIFont.Inter.semibold.size(of: 18)
        label.text = ""
        return label

    }()

    let buttonSignUp: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.Inter.bold.size(of: 18)
        button.backgroundColor = AppColors.purplePrimary
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()

    let signInLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Already have an account? Sign In", for: .normal)
        button.titleLabel?.font = UIFont.Inter.regular.size(of: 16)
        button.setTitleColor(AppColors.grayDark, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        //setConstraints()
        setInitialConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup UI
    private func setupViews() {
        backgroundColor = .white
        [headerLabel, subHeaderLabel, usernameTextField, emailTextField, passwordTextField, repeatPasswordTextField, buttonSignUp, signInLabelButton, warningLabel].forEach { addSubview($0) }
    }

}



extension AuthView {
    func setInitialConstraints() {
            NSLayoutConstraint.activate([
                headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
                headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                subHeaderLabel.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 45),
                subHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                subHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                usernameTextField.topAnchor.constraint(equalTo: subHeaderLabel.bottomAnchor, constant: 35),
                usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                usernameTextField.heightAnchor.constraint(equalToConstant: 57),
                passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
                passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                passwordTextField.heightAnchor.constraint(equalToConstant: 57),
                emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                emailTextField.heightAnchor.constraint(equalToConstant: 57),
                repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
                repeatPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                repeatPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 57),
                buttonSignUp.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 15),
                buttonSignUp.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                buttonSignUp.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                buttonSignUp.heightAnchor.constraint(equalToConstant: 57),
                signInLabelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
                signInLabelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                signInLabelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                signInLabelButton.heightAnchor.constraint(equalToConstant: 57),
                warningLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                warningLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                warningLabel.bottomAnchor.constraint(equalTo: signInLabelButton.topAnchor, constant: -50)
            ])

            switch state {
                case .signIn:
                emailTopConstraint = emailTextField.topAnchor.constraint(equalTo: subHeaderLabel.bottomAnchor, constant: 35)
                usernameHeightConstraint = usernameTextField.heightAnchor.constraint(equalToConstant: 0)
                repeatPasswordHeightConstraint = repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 0)

                case .signUp:
                emailTopConstraint = emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15)
                usernameHeightConstraint = usernameTextField.heightAnchor.constraint(equalToConstant: 57)
                repeatPasswordHeightConstraint = repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 57)
            }

            NSLayoutConstraint.activate([
                emailTopConstraint, usernameHeightConstraint, repeatPasswordHeightConstraint
            ])
        }

        func updateConstraintsForState() {
            
            emailTopConstraint.isActive = false
            usernameHeightConstraint.isActive = false
            repeatPasswordHeightConstraint.isActive = false

            switch state {
            case .signIn:
                emailTopConstraint = emailTextField.topAnchor.constraint(equalTo: subHeaderLabel.bottomAnchor, constant: 35)
                usernameHeightConstraint = usernameTextField.heightAnchor.constraint(equalToConstant: 0)
                repeatPasswordHeightConstraint = repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 0)

                usernameTextField.isHidden = true
                repeatPasswordTextField.isHidden = true

            case .signUp:
                usernameHeightConstraint = usernameTextField.heightAnchor.constraint(equalToConstant: 57)
                emailTopConstraint = emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15)
                repeatPasswordHeightConstraint = repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 57)

                usernameTextField.isHidden = false
                repeatPasswordTextField.isHidden = false
            }

            NSLayoutConstraint.activate([
                emailTopConstraint, usernameHeightConstraint, repeatPasswordHeightConstraint
            ])

            // Animate layout changes
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
}

extension AuthView {
    func showWarningMessage(_ message: String?) {
            warningLabel.text = message
        }
    
    func updateForState(_ state: AuthState) {
            switch state {
            case .signIn:
                headerLabel.text = "Welcome back 👋"
                subHeaderLabel.text = "I'm happy to see you again. You can continue where you left off by logging in."
                buttonSignUp.setTitle("Sign In", for: .normal)
                signInLabelButton.setTitle("Don't have an account? Sign up.", for: .normal)
                showWarningMessage(nil)
            case .signUp:
                headerLabel.text = "Welcome to NewsToDay"
                subHeaderLabel.text = "Hello, I guess you're new around here. You can start using the app after sign up."
                buttonSignUp.setTitle("Sign Up", for: .normal)
                signInLabelButton.setTitle("Already have an account? Sign In", for: .normal)
                showWarningMessage(nil)
            }
    }
}
