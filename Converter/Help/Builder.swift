//
//  Bulder.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class Builder {
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func getMainVC(model: ResponseModel) -> MainViewController {
        let models = CurrencyModel.getDictModels(from: model.Valute)
        
        let viewModel = MainCurrencyViewModel(models: models)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        vc.modalPresentationStyle = .fullScreen
        vc.viewModel = viewModel
        return vc
    }
    
    static func getChangeCurrencyVC(models: [String: Currency],selectedItem: BehaviorRelay<Currency>) -> ChangeCurrencyViewController {
        let castedModels = (Array(models.values) as! Array<CurrencyModelType>)
        
        let viewModel = ChangeCurrencyViewModel(models: castedModels, selectedItem: selectedItem)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "changeCurrencyVC") as! ChangeCurrencyViewController
        vc.modalPresentationStyle = .fullScreen
        vc.viewModel = viewModel
        
        return vc
        
    }
    
    
}
