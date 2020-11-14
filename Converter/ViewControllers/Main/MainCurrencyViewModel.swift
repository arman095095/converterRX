//
//  MainCurrencyViewModel.swift
//  Converter
//
//  Created by Arman Davidoff on 30.10.2020.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay


class MainCurrencyViewModel {
    
    enum ChangeType {
        case left
        case right
    }
    
    private var models: [String:Currency]
    
    var startCurrency: BehaviorRelay<Currency>
    var totalCurrency: BehaviorRelay<Currency>
    var calculateFor: ChangeType = .right
    var startValue = BehaviorRelay<String?>(value: nil)
    var totalValue = BehaviorRelay<String?>(value: nil)
    
    var dispose = DisposeBag()
    
    init(models: [String:Currency]) {
        self.models = models
        
        self.startCurrency = BehaviorRelay(value: models["USD"]!)
        self.totalCurrency = BehaviorRelay(value: models["RU"]!)
        
        self.setupBinding()
        self.startValue.accept("1")

    }
    
    private func setupBinding() {

        self.startValue.asDriver().drive(onNext: { text in
            guard let text = text else { return }
            self.totalValue.accept(self.calculateTotal(nominal: text))
        }).disposed(by: dispose)
        
    }
    
    private func calculateTotal(nominal: String?) -> String {
        switch calculateFor {
        case .left:
            return calculate(start: startCurrency.value, total: totalCurrency.value, nominal: nominal)
        case .right:
            return calculate(start: totalCurrency.value, total: startCurrency.value, nominal: nominal)
        }
    }
    
    func getModels() -> [String:Currency] {
        return models
    }
    
    private func calculate(start: Currency, total: Currency, nominal: String?) -> String {
        guard nominal != nil else { return "ошибка" }
        guard let X = Double(start.value) else { return "ошибка" }
        guard let Y = Double(total.value) else { return "ошибка" }
        guard let nominal = Double(nominal!) else { return "ошибка" }
        let result = (X / Y) * nominal * (Double(total.nominal)) / (Double(start.nominal))
        
        return String(format: "%.3f",result)
    }
}
