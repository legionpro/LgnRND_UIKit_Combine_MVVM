//
//  ViewController.swift
//  LgnRND_UIKit_Combine_MVVM
//
//  Created by Oleh Poremskyy on 31.05.2024.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var box = Set<AnyCancellable>()
    var viewModel = ViewModel(model: Model(name: "", password: "", passconf: ""))
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nameTextFiled: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var confirmTextField: UITextField!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextFiled.delegate = self
        passTextField.delegate = self
        confirmTextField.delegate = self
        binding()
    }

    func binding() {
        viewModel.$validationFlag
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
                self!.button.isEnabled = value
            })
            .store(in: &box)
    }
    
    func loginButton() {
        viewModel.loging()
    }

}

extension ViewController: UITextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.textFieldReset( textField.text ?? "", textField.tag)
    }
    
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.textFieldReset( textField.text ?? "", textField.tag)
    }
}

