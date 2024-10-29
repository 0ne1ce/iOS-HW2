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
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.wishTitleText
        title.font = UIFont.systemFont(ofSize: Constants.fontSize)
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    
    private func configureSlider() {
        let stack = UIStackView()
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
    }
}

//MARK: - CustomSlider
final class CustomSlider: UIView {
    //MARK: - Constants
    enum Constants {
        static let titleViewTop: CGFloat = 10
        static let titleViewLeading: CGFloat = 20
        
        static let sliderBottom: CGFloat = -10
        static let sliderLeading: CGFloat = 20
    }
    
    //MARK: - Properties
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    //MARK:- Initialization
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private functions
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleViewTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleViewLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading),
            
        ])
    }
    
    //MARK: - Actions
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
