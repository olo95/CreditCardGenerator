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
    
    var ccGenTextField: CCGenTextField!
    var ccGenValidateButton: CCGenValidateButton!
    var ccGenValidationIndicatorView: CCGenValidationIndicatorView!
    var ccGenGenerateButton: CCGenGenerateButton!
    
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
        setupMainStackView()
        setupInputStackView()
        setupOutputStackView()
    }
    
    private func setupMainStackView() {
        ccGenMainStackView = UIStackView(frame: view.frame)
        ccGenMainStackView.distribution = .fillEqually
        ccGenMainStackView.axis = .vertical
        view.addSubview(ccGenMainStackView)
    }
    
    private func setupInputStackView() {
        ccGenInputStackView = UIStackView()
        ccGenInputStackView.distribution = .fillEqually
        ccGenInputStackView.axis = .vertical
        ccGenMainStackView.addArrangedSubview(ccGenInputStackView)
        
        ccGenTextField = CCGenTextField()
        ccGenTextField.configure()
        ccGenInputStackView.addArrangedSubview(ccGenTextField)
        ccGenValidateButton = CCGenValidateButton()
        ccGenValidateButton.configure()
        ccGenInputStackView.addArrangedSubview(ccGenValidateButton)
    }
    
    private func setupOutputStackView() {
        ccGenOutputStackView = UIStackView()
        ccGenOutputStackView.distribution = .fillEqually
        ccGenOutputStackView.axis = .horizontal
        ccGenMainStackView.addArrangedSubview(ccGenOutputStackView)
        
        ccGenValidationIndicatorView = CCGenValidationIndicatorView()
        ccGenValidationIndicatorView.configure()
        ccGenOutputStackView.addArrangedSubview(ccGenValidationIndicatorView)
        ccGenGenerateButton = CCGenGenerateButton()
        ccGenGenerateButton.configure()
        ccGenOutputStackView.addArrangedSubview(ccGenGenerateButton)
    }
    
    private func bindUI() {
        ccGenTextField.rx.text
            .unwrap()
            .filter { $0.count == ConstantsCreditCard.length }
            .sample(ccGenValidateButton.rx.tap)
            .subscribe( onNext: { text in
                
            }).disposed(by: bag)
    }
}
