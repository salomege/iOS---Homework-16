//
//  Notelist VC.swift
//  Homework 16
//
//  Created by salome on 05.11.23.
//

import UIKit

final class NotelistVC: UIViewController {

    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var items = ItemDetails.favouriteItems

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let barButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(setupAddButtonAction)
        )
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemsDetailsTableViewCell.self, forCellReuseIdentifier: "itemDetailsCell")
    }
    
    @objc private func setupAddButtonAction() {
        let addNewItemToListViewController = AddNoteVC()
        addNewItemToListViewController.delegate = self
        navigationController?.pushViewController(addNewItemToListViewController, animated: true)
    }
}

// MARK: - TableVIew DataSource
extension NotelistVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemDetailsCell") as? ItemsDetailsTableViewCell {
            cell.configure(with: item)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - TableVIew Delegate
extension NotelistVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NoteDetailsVC = NoteDetailsVC()
        NoteDetailsVC.configure(with: items[indexPath.row])
        navigationController?.pushViewController(NoteDetailsVC, animated: true)
    }
}

// MARK: - AddNewItemDelegate
extension NotelistVC: AddNewItemDelegate {
    func addNewItem(with item: ItemDetails) {
        items.append(item)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:
                   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }}
}

