//
//  ViewController.swift
//  RxSwiftMVVM
//
//  Created by Dushyant Varshney on 26/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var viewModel = LoginViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
        configureServiceCallBacks()
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
 
    }

    private func configureBinding() {

        // binding
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailFieldViewModel.data)
            .disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordFieldViewModel.data)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .`do`(onNext:  { [unowned self] in
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
            }).subscribe(onNext: { [unowned self] in
                if self.viewModel.validForm() {
                    self.viewModel.signin()
                }
                else{
                    
                }
            }).disposed(by: disposeBag)
    }
    
    private func configureServiceCallBacks() {
        
        // loading
//        viewModel.isLoading
//            .asDriver()
//            .drive(loginButton.rx.isLoading)
//            .disposed(by: disposeBag)
        
        // errors
        
        viewModel.emailFieldViewModel.errorValue.asObservable()
            .filter { $0 != nil }
            .bind { errorMessage in

                self.showAlertWith(title: "", message: errorMessage!)

            }.disposed(by: disposeBag)
        
        viewModel.passwordFieldViewModel.errorValue.asObservable()
            .filter { $0 != nil }
            .bind { errorMessage in

                print(errorMessage)
                self.showAlertWith(title: "", message: errorMessage!)

            }.disposed(by: disposeBag)
        
        viewModel.errorMessage
            .asObservable()
            .filter { $0 != nil }
            .bind { errorMessage in
  
                print(errorMessage)
                self.showAlertWith(title: "", message: errorMessage!)
            }.disposed(by: disposeBag)
        
        // success
        viewModel.isSuccess
            .asObservable()
            .filter { $0 }.bind { result in
                self.showAlertWith(title: "", message: "Login Successfull!")

            }.disposed(by: disposeBag)
    }
    
    func showAlertWith(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

