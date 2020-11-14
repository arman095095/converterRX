//
//  ChangeCurrencyViewModel.swift
//  Converter
//
//  Created by Arman Davidoff on 30.10.2020.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

class ChangeCurrencyViewModel {
    
    init(models: [CurrencyModelType], selectedItem: BehaviorRelay<Currency>) {
        self.models = models
        self.selectedItem = selectedItem
    }
    
    private var models: [CurrencyModelType]
    var selectedItem: BehaviorRelay<Currency>
    
    func rowsCount() -> Int {
        return models.count
    }
    
    private func item(for indexPath: IndexPath) -> CurrencyModelType {
        return models[indexPath.row]
    }
    
    func itemForSend(for indexPath: IndexPath) -> Currency {
        return models[indexPath.row] as! Currency
    }
    
    func getItem(for indexPath: IndexPath) -> CurrencyModelType {
        var model = item(for: indexPath)
        model.selected = item(for: indexPath).name == self.selectedItem.value.name
        return model
    }
}
