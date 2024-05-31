//
//  ViewModel.swift
//  iOS
//
//  Created by Oleh Poremskyy on 31.05.2024.
//

import Foundation
import Combine


class ViewModel {
    var model: Model?
    @Published var validationFlag = false
    
    private lazy var userValidator: AnyPublisher<Bool,Never> = {
        guard let model = model else { return Just(false).eraseToAnyPublisher() }
        return model.$name
            .map{$0.count > 3}
            .eraseToAnyPublisher()
    }()
    
    private lazy var passValidator: AnyPublisher<Bool,Never> = {
        guard let model = model else { return Just(false).eraseToAnyPublisher() }
        return Publishers.CombineLatest(model.$password, model.$passconf)
            .map{( $0.count > 3 ) && ( $0 == $1 )}
            .eraseToAnyPublisher()
    }()
    
    init(model: Model? = nil) {
        self.model = model
        
        let _ = Publishers.CombineLatest(userValidator, passValidator)
            .map{ $0 && $1 }
            .assign(to: &$validationFlag)
    }
}

extension ViewModel {
    func loging() {
        guard let model = model else  { return }
        print("-login +++")
    }
}


extension ViewModel {
    func setModelName( name: String ) {
        self.model?.setName(name: name)
    }
    
    func setModelPassonf( passconf: String ) {
        self.model?.setPassconf(passconf: passconf)
    }
    
    func setModelPassword( password: String ) {
        self.model?.setPassword(password: password)
    }
    
    @objc func textFieldReset(_ text: String, _ tag: Int) {
        switch tag {
            case 1:
                setModelName(name: text )
            case 2:
                setModelPassword(password: text )
            case 3:
                setModelPassonf(passconf: text )
            default:
                print("wrong tag")
        }
    }
}
