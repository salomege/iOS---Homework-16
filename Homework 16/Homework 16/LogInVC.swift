//
//  ViewController.swift
//  Homework 16
//
//  Created by salome on 05.11.23.
//

import UIKit

class LogInVC: UIViewController {
    
    
    // MARK: - Properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 100, left: 50, bottom: 35, right: 50)
        return stackView
    }()
    
    private let formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(.gray)]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.backgroundColor = .white
        textField.textColor = UIColor(.black)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(.gray)]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightGray
        return button
    }()
    
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    // MARK: - Private Methods
    private func setup() {
        setupBackground()
        addMainSubviews()
        setupFormStackView()
        setupConstraints()
        setupSignInButtonAction()
    }
    
    private func setupBackground() {
        view.backgroundColor = .orange    }
    
    
    private func addMainSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(formStackView)
    }
    
    private func setupFormStackView() {
        formStackView.addArrangedSubview(loginTextField)
        formStackView.addArrangedSubview(passwordTextField)
        formStackView.addArrangedSubview(signInButton)
        
    }
    
    private func setupConstraints() {
        setupMainViewConstraints()
        setupFormConstraints()
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    
    
    private func setupFormConstraints() {
        NSLayoutConstraint.activate([
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func setupSignInButtonAction() {
        signInButton.addAction(
            UIAction(
                title: "",
                handler: { [weak self] _ in
                    let vc = NotelistVC()
                    self?.present(vc, animated: true)
                }
            ),
            for: .touchUpInside
        )
        signInButton.addAction(
            UIAction(
                title: "",
                handler: { [weak self] _ in
                    if let username = self?.loginTextField.text, let password = self?.passwordTextField.text {
                        do {
                            try self?.save(
                                service: "ServiceName",
                                account: username,
                                password: password.data(using: .utf8) ?? Data()
                            )
                            print("Username and Password saved.")
                        } catch {
                            print(error)
                        }
                    } else {
                        print("Username or Password is empty.")
                    }
                }
            ),
            for: .touchUpInside
        )
    
    }
    
    
    func save(
        service: String,
        account: String,
        password: Data
    ) throws {
        // service account password class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        print("saved")
    }
    
    private var isFirstTimeLogin = true

       @objc private func signInButtonTapped() {
           guard let username = loginTextField.text, let password = passwordTextField.text else {
               print("Please enter both username and password.")
               return
           }
           save(username: username, password: password)
       }

       private func save(username: String, password: String) {
           if isFirstTimeLogin {
               print("Welcome!")
               isFirstTimeLogin = false
           } else {
               print("Username and Password saved successfully.")
           }
       }
   }

