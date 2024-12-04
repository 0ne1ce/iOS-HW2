//
//  ViewController.swift
//  avchernyiPW2
//
//  Created by Алексей on 27.10.2024.
//

import UIKit

// MARK: - WishMakerViewController
final class WishMakerViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        
        static let wishTitleText: String = "WishMaker"
        static let secretTitleText: String = "CHROMAKOPIA"
        static let secretColor: UIColor = UIColor(red: 0, green: 0.222, blue: 0, alpha: 1)
        
        static let hexSize: Int = 6
        static let randomHexSymbols: String = "0123456789ABCDEF"
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -80
        static let stackLeading: CGFloat = 20
        
        static let titleTop: CGFloat = 30
        static let secretTitleTop: CGFloat = 120
        
        static let fontSize: Double = 32
        static let secretTitleFontSize: Double = 52
        
        static let buttonBottom: CGFloat = -20
        static let scheduleButtonBottom: CGFloat = -40
        static let buttonAnimatedBottom: CGFloat = 80
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
        
        static let standardMultiplier: CGFloat = 1
    }
    
    // MARK: - Variables
    private let hidingButton: UIButton = UIButton(type: .system)
    private let randomButton: UIButton = UIButton(type: .system)
    private let secretButton: UIButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishButton: UIButton = UIButton(type: .system)
    private let stack: UIStackView = UIStackView()
    private let titleLabel: UILabel = UILabel()
    private let secretTitle: UILabel = UILabel()
    private var hidingButtonCounter: Int = 0
    private var secretButtonCounter: Int = 0
    private var topSliderButtons: Array<UIButton> = []
    private var titleChanged: Bool = false
    
    private let sliderRedVariable = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlueVariable = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreenVariable = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    
    private var buttonBottomConstraints: Array<NSLayoutConstraint> = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    // MARK: - Private functions
    private func configureUI() {
        view.backgroundColor = .black
        
        configureTitle()
        configureScheduleButton()
        configureAddWishButton()
        configureSliders()
        configureTopSliderButtons()
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
    
    private func configureScheduleButton() {
        view.addSubview(scheduleWishButton)
        scheduleWishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scheduleWishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scheduleWishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.scheduleButtonBottom),
            scheduleWishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonTrailing),
            scheduleWishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -Constants.buttonTrailing),
            scheduleWishButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
        scheduleWishButton.layer.cornerRadius = Constants.buttonCornerRadius
        scheduleWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonFontSize)
        scheduleWishButton.setTitleColor(.white, for: .normal)
        scheduleWishButton.backgroundColor = .systemGray
        scheduleWishButton.alpha = Constants.buttonAlpha
        scheduleWishButton.setTitle("Schedule wish granting", for: .normal)
        
        scheduleWishButton.addTarget(self, action: #selector(scheduleWishButtonPressed), for: .touchUpInside)
        
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addWishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addWishButton.bottomAnchor.constraint(equalTo: scheduleWishButton.topAnchor, constant: Constants.buttonBottom),
            addWishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonTrailing),
            addWishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -Constants.buttonTrailing),
            addWishButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
        addWishButton.layer.cornerRadius = Constants.buttonCornerRadius
        addWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonFontSize)
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.backgroundColor = .systemGray
        addWishButton.alpha = Constants.buttonAlpha
        addWishButton.setTitle("My Wishes", for: .normal)
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        let sliderRed = sliderRedVariable
        let sliderGreen = sliderGreenVariable
        let sliderBlue = sliderBlueVariable
        
        sliderRed.backgroundColor = .black
        sliderGreen.backgroundColor = .black
        sliderBlue.backgroundColor = .black
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            stack.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: Constants.stackBottom)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.changeBackgroundColor()
            if (sliderRed.slider.value > Constants.visibleTitleBound && sliderGreen.slider.value > Constants.visibleTitleBound && sliderBlue.slider.value > Constants.visibleTitleBound) {
                UIView.animate(withDuration: Constants.titleChangeTime) {
                    self?.changeTitlesForLightBackground()
                }
                self?.titleChanged = true
            }
            else {
                if (self?.titleChanged == true) {
                    UIView.animate(withDuration: Constants.titleChangeTime) {
                        self?.changeTitlesForDarkBackground()
                    }
                    self?.titleChanged = false
                }
            }
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.changeBackgroundColor()
            if (sliderRed.slider.value > Constants.visibleTitleBound && sliderGreen.slider.value > Constants.visibleTitleBound && sliderBlue.slider.value > Constants.visibleTitleBound) {
                UIView.animate(withDuration: Constants.titleChangeTime) {
                    self?.changeTitlesForLightBackground()
                }
                self?.titleChanged = true
            }
            else {
                if (self?.titleChanged == true) {
                    UIView.animate(withDuration: Constants.titleChangeTime) {
                        self?.changeTitlesForDarkBackground()
                    }
                    self?.titleChanged = false
                }
            }
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.changeBackgroundColor()
            if (sliderRed.slider.value > Constants.visibleTitleBound && sliderGreen.slider.value > Constants.visibleTitleBound && sliderBlue.slider.value > Constants.visibleTitleBound) {
                UIView.animate(withDuration: Constants.titleChangeTime) {
                    self?.changeTitlesForLightBackground()
                }
                self?.titleChanged = true
            }
            else {
                if (self?.titleChanged == true) {
                    UIView.animate(withDuration: Constants.titleChangeTime) {
                        self?.changeTitlesForDarkBackground()
                    }
                    self?.titleChanged = false
                }
            }
        }
    }
    
    private func configureTopSliderButtons() {
        topSliderButtons.append(hidingButton)
        topSliderButtons.append(randomButton)
        topSliderButtons.append(secretButton)
        for button in topSliderButtons {
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonBottomConstraints.append(button.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: Constants.buttonBottom))
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
        view.backgroundColor = Constants.secretColor
        BackgroundColorModel.shared.backgroundColor = Constants.secretColor
        secretTitle.isHidden = false
    }
    
    private func originalBackground() {
        stack.isHidden = false
        titleLabel.isHidden = false
        hidingButton.isHidden = false
        randomButton.isHidden = false
        view.backgroundColor = .black
        changeTitlesForDarkBackground()
        sliderRedVariable.backgroundColor = .black
        sliderGreenVariable.backgroundColor = .black
        sliderBlueVariable.backgroundColor = .black
        secretTitle.isHidden = true
        BackgroundColorModel.shared.backgroundColor = .black
    }
    
    private func randomBackground() {
        let newColor: UIColor = UIColor().hexToRGB(hex: uniqueHex())
        let newRgba = newColor.rgba
        sliderRedVariable.slider.setValue(Float(newRgba.red), animated: true)
        sliderGreenVariable.slider.setValue(Float(newRgba.green), animated: true)
        sliderBlueVariable.slider.setValue(Float(newRgba.blue), animated: true)
        if (sliderRedVariable.slider.value > Constants.visibleTitleBound && sliderGreenVariable.slider.value > Constants.visibleTitleBound && sliderBlueVariable.slider.value > Constants.visibleTitleBound) {
            UIView.animate(withDuration: Constants.titleChangeTime) {
                self.titleLabel.textColor = .black
                self.sliderRedVariable.titleView.textColor = .black
                self.sliderGreenVariable.titleView.textColor = .black
                self.sliderBlueVariable.titleView.textColor = .black
            }
            titleChanged = true
        }
        else {
            if (self.titleChanged == true) {
                UIView.animate(withDuration: Constants.titleChangeTime) {
                    self.changeTitlesForDarkBackground()
                }
                titleChanged = false
            }
        }
        view.backgroundColor = newColor
        sliderRedVariable.backgroundColor = newColor
        sliderGreenVariable.backgroundColor = newColor
        sliderBlueVariable.backgroundColor = newColor
        BackgroundColorModel.shared.backgroundColor = newColor
        buttonsTitleColorChange(currentColor: newColor)
    }
    
    private func changeBackgroundColor() {
        let currentColor: UIColor = UIColor(red: CGFloat(sliderRedVariable.slider.value), green: CGFloat(sliderGreenVariable.slider.value), blue: CGFloat(sliderBlueVariable.slider.value), alpha: 1)
        self.view.backgroundColor = currentColor
        self.sliderRedVariable.backgroundColor = currentColor
        self.sliderGreenVariable.backgroundColor = currentColor
        self.sliderBlueVariable.backgroundColor = currentColor
        BackgroundColorModel.shared.backgroundColor = currentColor
        buttonsTitleColorChange(currentColor: currentColor)
    }
    
    private func buttonsTitleColorChange(currentColor: UIColor) {
        for button in topSliderButtons {
            button.setTitleColor(currentColor, for: .normal)
        }
        addWishButton.setTitleColor(currentColor, for: .normal)
        scheduleWishButton.setTitleColor(currentColor, for: .normal)
    }
    
    private func changeTitlesForLightBackground() {
        self.titleLabel.textColor = .black
        sliderRedVariable.titleView.textColor = .black
        sliderGreenVariable.titleView.textColor = .black
        sliderBlueVariable.titleView.textColor = .black
        BackgroundColorModel.shared.titleColor = .black
    }
    
    private func changeTitlesForDarkBackground() {
        self.titleLabel.textColor = .white
        self.sliderRedVariable.titleView.textColor = .white
        self.sliderGreenVariable.titleView.textColor = .white
        self.sliderBlueVariable.titleView.textColor = .white
        BackgroundColorModel.shared.titleColor = .white
    }
    
    private func uniqueHex() -> String {
        return String((0...Constants.hexSize).map{_ in Constants.randomHexSymbols.randomElement()!})
    }
    
    private func buttonsMoveDown() {
        for i in 0..<buttonBottomConstraints.count {
            buttonBottomConstraints[i].constant = Constants.buttonAnimatedBottom
        }
        self.view.layoutIfNeeded()
        hidingButton.setTitle("Show", for: .normal)
        hidingButton.titleLabel?.textColor = BackgroundColorModel.shared.backgroundColor
    }
    
    private func buttonsMoveUp() {
        for i in 0..<buttonBottomConstraints.count {
            buttonBottomConstraints[i].constant = Constants.buttonBottom
        }
        self.view.layoutIfNeeded()
        hidingButton.setTitle("Hide", for: .normal)
        hidingButton.titleLabel?.textColor = BackgroundColorModel.shared.backgroundColor
    }
    
    // MARK: - Actions
    @objc
    private func hidingButtonPressed(_ sender: UIButton) {
        if (hidingButtonCounter % 2 == 0) {
            UIView.animate(withDuration: Constants.buttonsMoveAnimationTime,
                           animations: {[self] in
                                buttonsMoveDown()
            }, completion: { [weak self] _ in
                self?.hidingButton.isEnabled = true
            })
            stack.isHidden = true
            hidingButtonCounter += 1
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
            hidingButtonCounter -= 1
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
            sliderRedVariable.backgroundColor = Constants.secretColor
            sliderGreenVariable.backgroundColor = Constants.secretColor
            sliderBlueVariable.backgroundColor = Constants.secretColor
            secretButtonCounter += 1
        }
        else {
            sliderRedVariable.slider.setValue(0, animated: false)
            sliderGreenVariable.slider.setValue(0, animated: false)
            sliderBlueVariable.slider.setValue(0, animated: false)
            if (hidingButtonCounter % 2 != 0) {
                hidingButtonCounter = 0
                buttonsMoveUp()
            }
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
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    @objc
    private func scheduleWishButtonPressed() {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UIColor
extension UIColor {
    //MARK: - Variables
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    //MARK: - Functions
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
