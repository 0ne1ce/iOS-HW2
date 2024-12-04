//
//  WishStoringViewController.swift
//  avchernyiPW2
//
//  Created by Алексей on 02.11.2024.
//

import UIKit

// MARK: - WishStoringViewController
final class WishStoringViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let tableCornerRadius: CGFloat = 25
        static let tableOffset: CGFloat = 25
        static let sections: Int = 2
        
        static let alertEditTitle: String = "Editing mode"
        static let alertSaveTitle: String = "Save"
        static let alertCancelTitle: String = "Cancel"
    }
    
    // MARK: - Variables
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    private let userDefaultsHelper: UserDefaultsHelper = UserDefaultsHelper()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .white
        wishArray = userDefaultsHelper.loadWishes()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.backgroundColor = BackgroundColorModel.shared.backgroundColor
    }
    
    // MARK: - Private functions
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .blue
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.tableOffset),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.tableOffset),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.tableOffset),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.tableOffset)
        ])
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func handleEditWish(at index: Int) {
        let currentWish = wishArray[index]
        
        let alertController = UIAlertController(title: Constants.alertEditTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField {textField in
            textField.text = currentWish
        }
        
        let saveAction = UIAlertAction(title: Constants.alertSaveTitle, style: .default) { [weak self] _ in
            guard let newWish = alertController.textFields?.first?.text, !newWish.isEmpty else { return }
            self?.wishArray[index] = newWish
            self?.table.reloadData()
            self?.userDefaultsHelper.saveWishes(self?.wishArray ?? [])
            
        }
        
        let cancelAction = UIAlertAction(title: Constants.alertCancelTitle, style: .cancel)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.addWish = {[weak self] inputText in
                self?.wishArray.append(inputText)
                tableView.reloadData()
                self?.userDefaultsHelper.saveWishes(self?.wishArray ?? [])
            }
            
            return addWishCell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.configure(with: wishArray[indexPath.row])
            
            wishCell.deleteWish = {[weak self] in
                self?.wishArray.remove(at: indexPath.row)
                tableView.reloadData()
                self?.userDefaultsHelper.saveWishes(self?.wishArray ?? [])
            }
            
            wishCell.editWish = {[weak self] in
                self?.handleEditWish(at: indexPath.row)
            }
            
            return wishCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sections
    }
}
