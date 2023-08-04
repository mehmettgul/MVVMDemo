//
//  WebService.swift
//  MVVM
//
//  Created by Mehmet Gül on 4.08.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}

class WebService {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoModel], CryptoError>) -> () ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError)) // veri hiç gelmediği için server'da bir hata var
            } else if let data = data {
                let cryptoList = try? JSONDecoder().decode([CryptoModel].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.parsingError)) // veri geldi ama ben işleyemedim.
                }
            }
        }.resume()
    }
    
}
