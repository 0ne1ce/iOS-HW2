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
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 20
        static let wishLabelOffset: CGFloat = 8
    }
    
    // MARK: - Variables
    static let reuseId: String = "WrittenWishCell"
    private let wishLabel: UILabel = UILabel()
    
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
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        wrap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrap.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wrap.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.wrapOffsetH),
            wrap.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -Constants.wrapOffsetH),
            wrap.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.wrapOffsetV)
        ])
        
        wrap.addSubview(wishLabel)
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wishLabel.centerXAnchor.constraint(equalTo: wrap.centerXAnchor),
            wishLabel.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.wishLabelOffset),
            wishLabel.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.wishLabelOffset),
            wishLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wishLabelOffset),
            wishLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.wishLabelOffset)
        ])
    }
}
