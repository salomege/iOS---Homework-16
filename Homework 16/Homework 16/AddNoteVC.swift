//
//  AddNoteVC.swift
//  Homework 16
//
//  Created by salome on 05.11.23.
//

import UIKit

protocol AddNewItemDelegate: AnyObject {
    func addNewItem(with item: ItemDetails)
}

final class AddNoteVC: UIViewController {
    
    // MARK: - Properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, mainTextField,  saveInfoButton])
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.backgroundColor = .systemGroupedBackground
        stackView.layer.cornerRadius = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title"
        return textField
    }()
    
    private let mainTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text"
        return textField
    }()
    
    private let saveInfoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.setTitle("Save Information", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    weak var delegate: AddNewItemDelegate?

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupSubviews()
        setupConstraints()

        setupButtonActions()
    }
    
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveInfoButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    
    private func setupButtonActions() {
    
        saveInfoButton.addAction(
            UIAction(
                handler: { [weak self] _ in
                    guard let self else { return }
                    delegate?.addNewItem(with: .init(
                        title: titleTextField.text ?? String(),
                        mainText: mainTextField.text ?? String()
                    ))
                    navigationController?.popViewController(animated: true)
                }
            ),
            for: .touchUpInside
        )
    }
}


