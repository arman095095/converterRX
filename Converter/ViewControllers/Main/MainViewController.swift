//
//  MainViewController.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class MainViewController: UIViewController {
    
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
 
    var viewModel: MainCurrencyViewModel!
    var dispose = DisposeBag()
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        setupViews()
        setupTextFields()
        setupLabels()
    }
    
    private func setupLabels() {
        self.viewModel.totalCurrency.asDriver().drive(onNext: { curr in
            self.viewModel.calculateFor = .left
            self.viewModel.startValue.accept(self.leftTextField.text)
            self.rightLabel.text = curr.name
            self.rightTextField.text = self.viewModel.totalValue.value
        }).disposed(by: dispose)
        
        self.viewModel.startCurrency.asDriver().drive(onNext: { curr in
            self.viewModel.calculateFor = .left
            self.viewModel.startValue.accept(self.leftTextField.text)
            self.leftLabel.text = curr.name
            self.rightTextField.text = self.viewModel.totalValue.value
        }).disposed(by: dispose)
    }
    
    private func setupTextFields() {
        leftTextField.rx.text.orEmpty.asDriver().drive(onNext: { text in
            self.viewModel.calculateFor = .left
            self.viewModel.startValue.accept(text)
            self.rightTextField.text = self.viewModel.totalValue.value
        }).disposed(by: dispose)
        
        rightTextField.rx.text.orEmpty.asDriver().drive(onNext: { text in
            self.viewModel.calculateFor = .right
            self.viewModel.startValue.accept(text)
            self.leftTextField.text = self.viewModel.totalValue.value
        }).disposed(by: dispose)
    }
  
    private func setupViews() {
        rightButton.titleLabel?.textAlignment = .center
        leftButton.titleLabel?.textAlignment = .center
    }
    
    @IBAction func leftAction(_ sender: Any) {
        let vc = Builder.getChangeCurrencyVC(models: viewModel.getModels(),selectedItem: viewModel.startCurrency)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rightAction(_ sender: Any) {
        let vc = Builder.getChangeCurrencyVC(models: viewModel.getModels(),selectedItem: viewModel.totalCurrency)
        present(vc, animated: true, completion: nil)
    }
}



