//
//  ItemDetailsViewController.swift
//  Homework 16
//
//  Created by salome on 05.11.23.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    // MARK: - Properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemImageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .systemGroupedBackground
        stackView.layer.cornerRadius = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Configure
    func configure(with model: ItemDetails) {
        itemImageView.image = model.image
        titleLabel.text = model.title
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
            itemImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
