//
//  WishCalendarViewController.swift
//  avchernyiPW2
//
//  Created by Алексей on 04.12.2024.
//

import UIKit

//MARK: - WishCalendarViewController
final class WishCalendarViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let contentInset: UIEdgeInsets = UIEdgeInsets()
        static let collectionTop: CGFloat = 40
    }
    
    // MARK: - Variables
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        configureUI()
    }
    
    // MARK: - Private functions
    private func configureUI() {
        view.backgroundColor = .white
        configureCollection()
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = BackgroundColorModel.shared.backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        /* Temporary line */
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: "WishEventCell")
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.collectionTop),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            WishEventCell.reuseIdentifier, for: indexPath)
            guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        wishEventCell.configure(
            with: WishEventModel(
                title: "Test",
                description: "Test description",
                startDate: "Start date",
                endDate: "End date"
            )
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowAutoLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
