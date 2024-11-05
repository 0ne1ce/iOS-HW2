//
//  AddWishCell.swift
//  avchernyiPW2
//
//  Created by Алексей on 04.11.2024.
//

import UIKit

// MARK: - AddWishCell
final class AddWishCell : UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    
    // MARK: - Variables
    private var input: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton(type: .system)
    private var addWish: ((String) -> ())?
    
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
    private func configureUI() {
        let wrap = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        wrap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrap.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wrap.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.wrapOffsetH),
            wrap.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.wrapOffsetH),
            wrap.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.wrapOffsetV)
        ])
        
        wrap.addSubview(addWishButton)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addWishButton.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wrapOffsetH),
            addWishButton.trailingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wrapOffsetH),
            addWishButton.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.wrapOffsetV),
            addWishButton.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: Constants.wrapOffsetV)
        ])
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc
    private func addWishButtonPressed() {
        
    }
}
