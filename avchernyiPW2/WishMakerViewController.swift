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
    private let hidingButton = UIButton(type: .system)
    private let randomButton = UIButton(type: .system)
    private let secretButton = UIButton(type: .system)
    private let stack = UIStackView()
    private let titleLabel = UILabel()
    private let secretTitle = UILabel()
    private var buttonCounter: Int = 0
    private var secretButtonCounter: Int = 0
    private var buttons: Array<UIButton> = []
    private var titleChanged: Bool = false
    
    private var buttonBottomConstraints: Array<NSLayoutConstraint> = []
    
    //MARK: - Constants
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        static let wishTitleText: String = "WishMaker"
        static let secretTitleText: String = "CHROMAKOPIA"
        
        static let hexSize: Int = 6
        static let randomHexSymbols: String = "0123456789ABCDEF"
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -40
        static let stackLeading: CGFloat = 20
        
        static let titleTop: CGFloat = 30
        static let secretTitleTop: CGFloat = 120
        
        static let fontSize: Double = 32
        static let secretTitleFontSize: Double = 52
        
        static let buttonBottom: CGFloat = -270
        static let buttonAnimatedBottom: CGFloat = -40
        static let buttonTrailing: CGFloat = -40
        static let secretButtonLeading: CGFloat = 40
        static let buttonHeight: CGFloat = 55
        static let buttonWidth: CGFloat = 80
        static let buttonCornerRadius: CGFloat = 15
        static let buttonFontSize: CGFloat = 16
        static let buttonAlpha: CGFloat = 0.85
        
        static let secretAnimationTime: Double = 1.8
        static let buttonsMoveAnimationTime: Double = 0.2
        static let colorSwitchTime: Double = 0.5
        static let titleChangeTime: Double = 0.5
        
        static let visibleTitleBound: Float = 0.65
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    //MARK: - Private functions
    private func configureUI() {
        view.backgroundColor = .black
        
        configureTitle()
        configureSlider()
        configureButtons()
        configureSecretTitle()
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
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: 1)
            if (sliderRed.slider.value > Constants.visibleTitleBound && sliderGreen.slider.value > Constants.visibleTitleBound && sliderBlue.slider.value > Constants.visibleTitleBound) {
                UIView.animate(withDuration: Constants.titleChangeTime) {
                    self?.titleLabel.textColor = .black
                }
                self?.titleChanged = true
            }
            else {
                if (self?.titleChanged == true) {
                    UIView.animate(withDuration: Constants.titleChangeTime) {
                        self?.titleLabel.textColor = .white
                    }
                    self?.titleChanged = false
                }
            }
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: 1)
            if (sliderRed.slider.value > Constants.visibleTitleBound && sliderGreen.slider.value > Constants.visibleTitleBound && sliderBlue.slider.value > Constants.visibleTitleBound) {
                UIView.animate(withDuration: Constants.titleChangeTime) {
                    self?.titleLabel.textColor = .black
                }
                self?.titleChanged = true
            }
            else {
                if (self?.titleChanged == true) {
                    UIView.animate(withDuration: Constants.titleChangeTime) {
                        self?.titleLabel.textColor = .white
                    }
                    self?.titleChanged = false
                }
            }
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: 1)
            if (sliderRed.slider.value > Constants.visibleTitleBound && sliderGreen.slider.value > Constants.visibleTitleBound && sliderBlue.slider.value > Constants.visibleTitleBound) {
                UIView.animate(withDuration: Constants.titleChangeTime) {
                    self?.titleLabel.textColor = .black
                }
                self?.titleChanged = true
            }
            else {
                if (self?.titleChanged == true) {
                    UIView.animate(withDuration: Constants.titleChangeTime) {
                        self?.titleLabel.textColor = .white
                    }
                    self?.titleChanged = false
                }
            }
        }
    }
    
    private func configureButtons() {
        buttons.append(hidingButton)
        buttons.append(randomButton)
        buttons.append(secretButton)
        for button in buttons {
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonBottomConstraints.append(button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.buttonBottom))
            buttonBottomConstraints.last?.isActive = true
            button.layer.cornerRadius = Constants.buttonCornerRadius
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonFontSize)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemGray
            button.alpha = Constants.buttonAlpha
        }
        configureHidingButton()
        configureRandomButton()
        configureSecretButton()
    }
    
    private func configureHidingButton() {
        NSLayoutConstraint.activate([
            hidingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonTrailing),
            hidingButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            hidingButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
        ])
        hidingButton.setTitle("Hide", for: .normal)
        
        hidingButton.addTarget(self, action: #selector(hidingButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureRandomButton() {
        NSLayoutConstraint.activate([
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            randomButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
        ])
        randomButton.setTitle("Random", for: .normal)
        
        randomButton.addTarget(self, action: #selector(randomButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureSecretButton() {
        NSLayoutConstraint.activate([
            secretButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.secretButtonLeading),
            secretButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            secretButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
        ])
        secretButton.setTitle("Chroma?", for: .normal)
        
        secretButton.addTarget(self, action: #selector(secretButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureSecretTitle() {
        secretTitle.translatesAutoresizingMaskIntoConstraints = false
        secretTitle.text = Constants.secretTitleText
        secretTitle.font = UIFont.systemFont(ofSize: Constants.secretTitleFontSize)
        secretTitle.textColor = .black
        secretTitle.font = UIFont.boldSystemFont(ofSize: Constants.secretTitleFontSize)
        
        view.addSubview(secretTitle)
        NSLayoutConstraint.activate([
            secretTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secretTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.secretTitleTop)
        ])
        secretTitle.isHidden = true
    }
    
    private func secretBackground() {
        stack.isHidden = true
        titleLabel.isHidden = true
        secretButton.isHidden = true
        hidingButton.isHidden = true
        randomButton.isHidden = true
        view.backgroundColor = UIColor(red: 0, green: 0.222, blue: 0, alpha: 1)
        secretTitle.isHidden = false
    }
    
    private func originalBackground() {
        stack.isHidden = false
        titleLabel.isHidden = false
        hidingButton.isHidden = false
        randomButton.isHidden = false
        view.backgroundColor = .systemPink
        secretTitle.isHidden = true
    }
    
    private func randomBackground() {
        view.backgroundColor = UIColor().hexToRGB(hex: uniqueHex())
    }
    
    private func uniqueHex() -> String {
        return String((0...Constants.hexSize).map{_ in Constants.randomHexSymbols.randomElement()!})
    }
    
    private func buttonsMoveDown() {
        for i in 0..<buttonBottomConstraints.count {
            buttonBottomConstraints[i].constant = Constants.buttonAnimatedBottom
        }
        self.view.layoutIfNeeded()
    }
    
    private func buttonsMoveUp() {
        for i in 0..<buttonBottomConstraints.count {
            buttonBottomConstraints[i].constant = Constants.buttonBottom
        }
        self.view.layoutIfNeeded()
    }
    
    private func backgroundChangeBySlider() {
        
    }
    
    //MARK: - Actions
    @objc
    private func hidingButtonPressed(_ sender: UIButton) {
        if (buttonCounter % 2 == 0) {
            UIView.animate(withDuration: Constants.buttonsMoveAnimationTime,
                           animations: {[self] in
                                buttonsMoveDown()
            }, completion: { [weak self] _ in
                self?.hidingButton.isEnabled = true
            })
            stack.isHidden = true
            buttonCounter += 1
        }
        else {
            UIView.animate(withDuration: Constants.buttonsMoveAnimationTime,
                           animations: {[self] in
                                buttonsMoveUp()
            }, completion: { [weak self] _ in
                self?.hidingButton.isEnabled = true
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.buttonsMoveAnimationTime) {
                self.stack.isHidden = false
            }
            buttonCounter -= 1
        }
    }
    
    @objc
    private func randomButtonPressed(_ sender: UIButton) {
        UIView.animate(
            withDuration: Constants.colorSwitchTime,
            animations: {[self] in
                randomBackground()
            },
            completion: {
                [weak self] _ in
                self?.secretButton.isEnabled = true
            })
    }
    
    @objc
    private func secretButtonPressed(_ sender: UIButton) {
        if (secretButtonCounter % 2 == 0) {
            UIView.animate(
                withDuration: Constants.secretAnimationTime,
                animations: {[self] in
                    secretBackground()
                },
                completion: {
                    [weak self] _ in
                    self?.secretButton.isEnabled = true
                })
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.secretAnimationTime) {
                self.secretButton.isHidden = false
            }
            secretButtonCounter += 1
        }
        else {
            UIView.animate(
                withDuration: Constants.secretAnimationTime,
                animations: {[self] in
                    originalBackground()
                },
                completion: {
                    [weak self] _ in
                    self?.secretButton.isEnabled = true
                })
            secretButtonCounter -= 1
        }
    }
}

//MARK: - UIColor
extension UIColor {
    func hexToRGB(hex: String) -> UIColor {
        let formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb : UInt64 = 0
        Scanner (string: formattedHex).scanHexInt64(&rgb)
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgb & 0x0000FF) / 255.0,
                       alpha: 1)
    }
}
