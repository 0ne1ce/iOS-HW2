//
//  AddWishCell.swift
//  avchernyiPW2
//
//  Created by Алексей on 04.11.2024.
//

import UIKit

// MARK: - AddWishCell
final class AddWishCell : UITableViewCell, UITextViewDelegate {
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
        
        static let buttonOffsetTrailing: CGFloat = 20
        static let buttonSize: CGFloat = 44
        
        static let addWishButtonTitle: String = "Add"
        static let placeholderText = "Type shi"
    }
    
    // MARK: - Variables
    private var input: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton(type: .system)
    private let wrap: UIView = UIView()
    
    // MARK: - Properties
    var addWish: ((String) -> ())?
    
    static let reuseId: String = "AddWishCell"
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
    
    // MARK: - Public Methods
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.placeholderText
            textView.textColor = .lightGray
        }
    }
    
    // MARK: - Private functions
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(wrap)
        
        configureButton()
        configureWrap()
        ConfigureTextView()
    }
    
    private func configureButton() {
        addSubview(addWishButton)
        addWishButton.setTitle(Constants.addWishButtonTitle, for: .normal)
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
        addWishButton.backgroundColor = .systemGray
        
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.layer.cornerRadius = Constants.radius
        NSLayoutConstraint.activate([
            addWishButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            addWishButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            addWishButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.buttonOffsetTrailing),
            addWishButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapOffsetV),
            addWishButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.wrapOffsetV)
        ])
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureWrap() {
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.radius
        
        wrap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrap.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.wrapOffsetLeading),
            wrap.trailingAnchor.constraint(equalTo: addWishButton.leadingAnchor, constant: -Constants.wrapOffsetTrailing),
            wrap.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.wrapOffsetV)
        ])
        
        wrap.addSubview(input)
    }
    
    private func ConfigureTextView() {
        input.text = Constants.placeholderText
        input.font = UIFont.systemFont(ofSize: Constants.fontSize)
        input.textColor = .lightGray
        input.isScrollEnabled = true
        input.textContainer.maximumNumberOfLines = .zero
        input.textContainer.lineBreakMode = .byWordWrapping
        input.delegate = self
        input.backgroundColor = .white
        
        input.translatesAutoresizingMaskIntoConstraints = false
        input.layer.cornerRadius = Constants.radius
        NSLayoutConstraint.activate([
            input.centerXAnchor.constraint(equalTo: wrap.centerXAnchor),
            input.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.inputOffsetV),
            input.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.inputOffsetV),
            input.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.inputOffsetH),
            input.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.inputOffsetH)
        ])
    }
    
    //MARK: - Actions
    @objc
    private func addWishButtonPressed() {
        guard let inputText = input.text, !inputText.isEmpty, inputText != Constants.placeholderText || input.textColor != .lightGray else {
            return
        }
        addWish?(
            inputText
        )
        input.text = Constants.placeholderText
        input.textColor = .lightGray
    }
}
