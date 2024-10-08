//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by Nikhil Hore on 08/10/2024.
//

import UIKit

class ViewController: UIViewController {

    var numberOfConversions: Int = 0

    lazy var conversionsCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "0 conversions"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var temperatureInputTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter temperature in °C"
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 5.0
        return textField
    }()

    lazy var convertButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("Convert to °F", for: .normal)
        button.addTarget(
            self,
            action: #selector(convertTemperatureFromCelsiusToFahrenheit),
            for: .touchUpInside
        )
        return button
    }()

    lazy var temperatureOutputLabel: UILabel = {
        let label = UILabel()
        label.text = "~Result~"
        label.textColor = .white
        label.font = .systemFont(ofSize: 21.0)
        label.textAlignment = .center
        return label
    }()

    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            temperatureInputTextField,
            convertButton,
            temperatureOutputLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        view.backgroundColor = .systemTeal
        view.addSubview(conversionsCounterLabel)
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            conversionsCounterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            conversionsCounterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),

            verticalStackView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor
                .constraint(equalTo: view.centerYAnchor),

            temperatureInputTextField.widthAnchor.constraint(equalToConstant: 240.0),
            convertButton.widthAnchor.constraint(equalToConstant: 150.0)
        ])
    }

    @objc func convertTemperatureFromCelsiusToFahrenheit() {
        let temperatureInput = temperatureInputTextField.text ?? ""
        if temperatureInput.isEmpty {
            showAlert()
            temperatureOutputLabel.text = "~Result~"
        } else {
            let temperatureInCelsius = Double(temperatureInput) ?? 0.0
            let temperatureInFahrenheit = temperatureInCelsius * 9 / 5 + 32
            temperatureOutputLabel.text = "\(temperatureInFahrenheit) °F"

            updateConversionsCounter()
        }
    }

    func showAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Please enter a temperature.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func updateConversionsCounter() {
        numberOfConversions += 1
        conversionsCounterLabel.text = "\(numberOfConversions) conversions"
    }
}

class CustomTextField: UITextField {

    // Custom class created to add padding inside TextField
    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
