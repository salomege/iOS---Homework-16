//
//  ItemsDetailsTableViewCell.swift
//  Homework 16
//
//  Created by salome on 05.11.23.
//

import UIKit

class ItemsDetailsTableViewCell: UITableViewCell {

    // MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textColor = .purple
        return label
    }()
    
    private let MainText: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "Helvetica-Bold", size: 14)
        text.textColor = .purple
        return text
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        MainText.text = nil
    }
    
    // MARK: - Configure
    func configure(with model: ItemDetails) {
        titleLabel.text = model.title
        //MainText.text = model.mainText
    }

    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(MainText)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}
