//
//  WishEventCell.swift
//  avchernyiPW2
//
//  Created by Алексей on 04.12.2024.
//

import UIKit

// MARK: - WishEventCell
final class WishEventCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        static let offset: CGFloat = 20
        static let titleTopOffset: CGFloat = 15
        static let innerOffsetV: CGFloat = 5
        static let innerOffsetH: CGFloat = 10
        static let cornerRadius: CGFloat = 15
        static let backgroundColor: UIColor = .white
        static let wrapSize: CGFloat = 100
        
        static let fontSize: CGFloat = 16
        
        static let labelHeight: CGFloat = 20
        
    }
    // MARK: - Properties
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.offset),
            wrapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.offset),
            wrapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.offset),
            wrapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.offset)
        ])
        
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
        
    }
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: Constants.titleTopOffset),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.innerOffsetH),
            titleLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.innerOffsetH),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
        titleLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        titleLabel.textColor = .black
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.textColor = .black
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.innerOffsetV),
            descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.innerOffsetH),
            descriptionLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.innerOffsetH),
            descriptionLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        descriptionLabel.textColor = .black
    }
    
    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.textColor = .black
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.innerOffsetV),
            startDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.innerOffsetH),
            startDateLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            startDateLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        startDateLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        startDateLabel.textColor = .black
    }
    
    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.textColor = .black
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            endDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.innerOffsetV),
            endDateLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: Constants.innerOffsetV),
            endDateLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            endDateLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        endDateLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        endDateLabel.textColor = .red
    }
    
}
