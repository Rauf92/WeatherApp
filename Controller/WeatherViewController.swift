//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rauf Aliyev on 17.01.22.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    var inputTextField = UITextField()
    var weatherManager = WeatherManager()
    
    let imageView: UIImageView = {
        let background = UIImage(named: "background")
        var imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = background
        return imageView
    }()
    
    let locationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "location.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "Search"
        textField.textAlignment = .right
        textField.layer.cornerRadius = 8
        textField.clearButtonMode = .always
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let bottomStackView: UIStackView = {
      let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 6
        stackView.alignment =  .trailing
        stackView.alignment = .center
        return stackView
    }()
    
    var weatherIcon: UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(systemName: "cloud")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        return icon
    }()
    
    var weatherLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15 C"
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 44)
        label.textColor = .black
        return label
    }()
    
    let weatherCountry: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Russian"
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 44)
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        weatherManager.delegate = self
        setupBackground()
    }
    

    func setupBackground(){
        view.addSubview(imageView)
        view.addSubview(topStackView)
        view.addSubview(bottomStackView)
        
        topStackView.addArrangedSubview(locationButton)
        topStackView.addArrangedSubview(textField)
        topStackView.addArrangedSubview(searchButton)
        bottomStackView.addArrangedSubview(weatherIcon)
        bottomStackView.addArrangedSubview(weatherLabel)
        bottomStackView.addArrangedSubview(weatherCountry)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topStackView.heightAnchor.constraint(equalToConstant: 40),
            
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 50),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 120),
            bottomStackView.heightAnchor.constraint(equalToConstant: 250),
            bottomStackView.widthAnchor.constraint(equalToConstant: 250),
            
            weatherIcon.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 100),
            weatherIcon.widthAnchor.constraint(equalToConstant: 100),
            
            weatherLabel.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor),
            weatherLabel.heightAnchor.constraint(equalToConstant: 100),
            weatherLabel.widthAnchor.constraint(equalToConstant: 100),
            
            weatherCountry.heightAnchor.constraint(equalToConstant: 100),
            weatherCountry.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        searchButton.addTarget(self, action: #selector(getTextFieldText), for: .touchUpInside)
    }
    
    @objc func getTextFieldText(){
        inputTextField.text = textField.text
        weatherCountry.text = inputTextField.text
        weatherManager.fetchWeather(inputTextField.text!)
      
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.text = textField.text
        weatherCountry.text = inputTextField.text
        weatherManager.fetchWeather(inputTextField.text!)
        return true
    }
}

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel) {
        print("here is \(weather.temperatureString)")
        
        DispatchQueue.main.async {
            self.weatherLabel.text = "\(weather.temperatureString) °C"
            self.weatherIcon.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    
    
}

