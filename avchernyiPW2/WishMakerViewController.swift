//
//  ViewController.swift
//  avchernyiPW2
//
//  Created by Алексей on 27.10.2024.
//

import UIKit

//MARK: - WishMakerViewController
final class WishMakerViewController: UIViewController {
    //MARK: - Variables
    private let button = UIButton(type: .system)
    private let stack = UIStackView()
    private let titleLabel = UILabel()
    private var buttonCounter: Int = 0
    
    //MARK: - Constants
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 255
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        static let wishTitleText: String = "WishMaker"
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -40
        static let stackLeading: CGFloat = 20
        
        static let titleTop: CGFloat = 30
        
        static let fontSize: Double = 32
        
        static let buttonBottom: CGFloat = -270
        static let buttonTrailing: CGFloat = -40
        static let buttonHeight: CGFloat = 55
        static let buttonWidth: CGFloat = 120
        static let buttonCornerRadius: CGFloat = 15
        static let buttonFontSize: CGFloat = 16
        static let buttonAlpha: CGFloat = 0.85
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    //MARK: - Private functions
    private func configureUI() {
        view.backgroundColor = .systemPink
        
        configureTitle()
        configureSlider()
        configureButton()
    }
    
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.wishTitleText
        titleLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    
    private func configureSlider() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = .systemRed
            
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = .systemBlue
            
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = .systemGreen
            
        }
    }
    
    private func configureButton() {
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.buttonBottom),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonTrailing),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
        ])
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.backgroundColor = .systemGray
        button.setTitle("Sliders off/on", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonFontSize)
        button.setTitleColor(.white, for: .normal)
        button.alpha = Constants.buttonAlpha
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc
    private func buttonPressed(_ sender: UIButton) {
        if (buttonCounter % 2 == 0) {
            stack.isHidden = true
            buttonCounter += 1
        }
        else {
            stack.isHidden = false
            buttonCounter -= 1
        }
    }
}
