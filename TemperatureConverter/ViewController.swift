//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by Nikhil Hore on 08/10/2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var temperatureInputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter temperature in °C"
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        view.backgroundColor = .systemTeal
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor
                .constraint(equalTo: view.centerYAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 200.0)
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
}
