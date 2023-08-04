//
//  CryptoViewModel.swift
//  MVVM
//
//  Created by Mehmet Gül on 4.08.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    // kullanıcıya göstermek ya da VC ye atmak istediğimiz verileri tutuyoruz. VC den erişicez. YAYINLAMA
    let cryptos: PublishSubject<[CryptoModel]> = PublishSubject() // Bu yapı sayesinde bu listeyi burda elde edip ViewController'a atıyoruz.
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject() // veri alınırken bekleme aşaması için.
    
    func requestData() {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
        
    }
    
}
