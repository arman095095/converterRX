//
//  NetworkManager.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

class NetworkManager {
    
    enum URLs: String {
        case apiCurrency = "https://www.cbr-xml-daily.ru/daily_json.js"
    }
    
    func fetchCurrency(complition: @escaping (ResponseModel?,Error?) -> ()) {
        guard let url = URL(string: URLs.apiCurrency.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(nil,error)
                return
            }
            guard let data = data else {
                complition(nil,nil)
                return
            }
            guard let response = try? JSONDecoder().decode(ResponseModel.self, from: data) else {
                complition(nil,nil)
                return
            }
            complition(response,nil)
        }.resume()
    }
}
