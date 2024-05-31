//
//  Model.swift
//  iOS
//
//  Created by Oleh Poremskyy on 31.05.2024.
//

import Foundation
import Combine

class Model {
    @Published private(set) var name: String
    @Published private(set) var password: String
    @Published private(set) var passconf: String
    
    init(name: String, password: String, passconf: String) {
        self.name = name
        self.password = password
        self.passconf = passconf
    }
}

extension Model {
    func setName(name: String) {
        self.name = name
    }
    func setPassword(password: String) {
        self.password = password
    }
    func setPassconf(passconf: String) {
        self.passconf = passconf
    }
}
