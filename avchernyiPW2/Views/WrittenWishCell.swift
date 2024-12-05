//
//  WrittenWishCell.swift
//  avchernyiPW2
//
//  Created by Алексей on 02.11.2024.
//

import UIKit

// MARK: - WrittenWishCell
final class WrittenWishCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let radius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetLeading: CGFloat = 20
        static let wrapOffsetTrailing: CGFloat = 10
        static let inputOffsetV: CGFloat = 2
        static let inputOffsetH: CGFloat = 8
        static let fontSize: CGFloat = 16
        static let buttonAlpha: CGFloat = 0.85
        
        static let buttonOffsetInsideTrailing: CGFloat = 10
        static let buttonOffsetTrailing: CGFloat = 20
        static let buttonSize: CGFloat = 44
        
        static let wishLabelOffsetV: CGFloat = 5
        static let wishLabelOffsetH: CGFloat = 8
        static let wishLabelViewFontSize: CGFloat = 16
        
        static let deleteButtonTitle: String = "🗑"
        static let editButtonTitle: String = "🖍"
    }
    
    // MARK: - Variables
    static let reuseId: String = "WrittenWishCell"
    private let wishLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let deleteButton: UIButton = UIButton(type: .system)
    private let editButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    var deleteWish: (() -> Void)?
    var editWish: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: - Private functions
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(wrap)
        
        configureDeleteButton()
        configureEditButton()
        configureWrap()
        configureLabel()
    }
    
    private func configureWrap() {
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.radius
        
        wrap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrap.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            wrap.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.wrapOffsetLeading),
            wrap.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -Constants.wrapOffsetTrailing),
            wrap.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.wrapOffsetV)
        ])
    }
    
    private func configureLabel() {
        wrap.addSubview(wishLabel)
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wishLabel.centerXAnchor.constraint(equalTo: wrap.centerXAnchor),
            wishLabel.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.wishLabelOffsetV),
            wishLabel.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.wishLabelOffsetV),
            wishLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wishLabelOffsetH),
            wishLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.wishLabelOffsetH)
        ])
        wishLabel.font = UIFont.systemFont(ofSize: Constants.wishLabelViewFontSize)
        wishLabel.numberOfLines = .zero
        wishLabel.lineBreakMode = .byWordWrapping
        wishLabel.textColor = .black
    }
    
    private func configureDeleteButton() {
        addSubview(deleteButton)
        deleteButton.setTitle(Constants.deleteButtonTitle, for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
        deleteButton.backgroundColor = .systemGray
        deleteButton.alpha = Constants.buttonAlpha
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.layer.cornerRadius = Constants.radius
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            deleteButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.buttonOffsetTrailing),
            deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapOffsetV),
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.wrapOffsetV)
        ])
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
    }
    
    private func configureEditButton() {
        addSubview(editButton)
        editButton.setTitle(Constants.editButtonTitle, for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
        editButton.backgroundColor = .systemGray
        editButton.alpha = Constants.buttonAlpha
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.layer.cornerRadius = Constants.radius
        NSLayoutConstraint.activate([
            editButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            editButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -Constants.buttonOffsetInsideTrailing),
            editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapOffsetV),
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.wrapOffsetV)
        ])
        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    @objc
    private func deleteButtonPressed() {
        deleteWish?()
    }
    
    @objc
    private func editButtonPressed() {
        editWish?()
    }
}
