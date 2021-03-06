//
//  CCGenViewController.swift
//  CreditCardGenerator
//
//  Created by Alexander Stolar on 16.01.2018.
//  Copyright © 2018 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class CCGenViewController: UIViewController {
    
    let bag = DisposeBag()
    let viewModel = CCGenViewModel()
    
    var ccGenTextField: CCGenTextField!
    var ccGenValidateButton: CCGenValidateButton!
    var ccGenValidationIndicatorView: CCGenValidationIndicatorView!
    var ccGenGenerateButton: CCGenGenerateButton!
    var ccGenIndicatorView: UIActivityIndicatorView!
    
    var ccGenMainStackView: UIStackView!
    var ccGenInputStackView: UIStackView!
    var ccGenOutputStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.lightGray
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        setupMainStackView()
        setupInputStackView()
        setupOutputStackView()
    }
    
    private func setupMainStackView() {
        ccGenMainStackView = UIStackView()
        ccGenMainStackView.translatesAutoresizingMaskIntoConstraints = false
        ccGenMainStackView.distribution = .fillEqually
        ccGenMainStackView.axis = .vertical
        view.addSubview(ccGenMainStackView)
        
        view.addConstraints([
            NSLayoutConstraint(item: ccGenMainStackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: ccGenMainStackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: ccGenMainStackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: ccGenMainStackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    private func setupInputStackView() {
        ccGenInputStackView = UIStackView()
        ccGenInputStackView.translatesAutoresizingMaskIntoConstraints = false
        ccGenInputStackView.distribution = .fillEqually
        ccGenInputStackView.axis = .vertical
        ccGenMainStackView.addArrangedSubview(ccGenInputStackView)
        
        ccGenTextField = CCGenTextField()
        ccGenTextField.configure()
        ccGenInputStackView.addArrangedSubview(ccGenTextField)
        ccGenGenerateButton = CCGenGenerateButton(type: .system)
        ccGenGenerateButton.configure()
        ccGenInputStackView.addArrangedSubview(ccGenGenerateButton)
    }
    
    private func setupOutputStackView() {
        ccGenOutputStackView = UIStackView()
        ccGenOutputStackView.translatesAutoresizingMaskIntoConstraints = false
        ccGenOutputStackView.distribution = .fillEqually
        ccGenOutputStackView.axis = .horizontal
        ccGenMainStackView.addArrangedSubview(ccGenOutputStackView)
        
        ccGenValidationIndicatorView = CCGenValidationIndicatorView()
        ccGenValidationIndicatorView.configure()
        ccGenOutputStackView.addArrangedSubview(ccGenValidationIndicatorView)
        ccGenValidateButton = CCGenValidateButton(type: .system)
        ccGenValidateButton.configure()
        ccGenOutputStackView.addArrangedSubview(ccGenValidateButton)
        ccGenIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ccGenOutputStackView.addArrangedSubview(ccGenIndicatorView)
    }
    
    private func bindUI() {
        viewModel.requestProcessStatus.bind(to: ccGenValidationIndicatorView.requestProcessStatus).disposed(by: bag)
        
        ccGenGenerateButton.rx.tap
            .subscribe( onNext: { _ in
                self.viewModel.requestProcessStatus.onNext(.noRequest)
                self.ccGenTextField.text = ""
                guard let randomCreditCard = CCGenRandomNumberManager.default.generateRandomCreditCard() else {
                    return
                }
                for char in randomCreditCard {
                    self.ccGenTextField.text! += String(char)
                    self.ccGenTextField.sendActions(for: .valueChanged)
                }
                for _ in 0 ..< 7 {
                    self.ccGenTextField.text! += "0"
                    self.ccGenTextField.sendActions(for: .valueChanged)
                }
        }).disposed(by: bag)
        
        ccGenTextField.rx.text
            .unwrap()
            .filter { $0.count == ConstantsCreditCard.length }
            .sample(ccGenValidateButton.rx.tap)
            .subscribe( onNext: { text in
                let onlyCCNumber = text[ConstantsCreditCardTemplate.creditCardNumber].replacingOccurrences(of: " ", with: "")
                self.viewModel.creditCardToValidate.onNext(onlyCCNumber)
            }).disposed(by: bag)
        
        viewModel.isRequestInProcess
            .subscribe( onNext: { isRequestInProcess in
                if isRequestInProcess {
                    UIView.animate(withDuration: 0.3) {
                        self.ccGenIndicatorView.startAnimating()
                    }
                } else {
                    UIView.animate(withDuration: 0.3) {
                        DispatchQueue.main.async {
                            self.ccGenIndicatorView.stopAnimating()
                        }
                    }
                }
        }).disposed(by: bag)
    }
    
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
