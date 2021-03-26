//
//  LoginViewModel.swift
//  RxSwiftMVVM
//
//  Created by Dushyant Varshney on 26/03/21.
//
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel  {
    
    let model: LoginModel = LoginModel()
    private let disposeBag = DisposeBag()
 
    let emailFieldViewModel = EmailViewModel()
    let passwordFieldViewModel = PasswordTextFieldViewModel()
 

    let isLoading = BehaviorRelay(value: false)
    var isSuccess = BehaviorRelay(value: false)
    var errorMessage = BehaviorRelay<String?>(value: nil)
 
     func validForm() -> Bool {
         return emailFieldViewModel.validateCredentials() &&   passwordFieldViewModel.validateCredentials()
     }
 
     func signin() {
        
         model.email     = emailFieldViewModel.data.value
         model.password  = passwordFieldViewModel.data.value
    
        let request = LoginService(email: model.email, password: model.password)

        LoginService.execute(request)()
             .`do`(onSubscribe: { [weak self] in
                self?.isLoading.accept(true)
             })
             .subscribe(onNext: { [weak self] response in
                let res = response as! [String: Any]
                if (res["result"] as! Int) == 1{
                    self?.isSuccess.accept(true)
                    self?.saveUserData(res: res)
                    self?.errorMessage.accept("Login success!")
                }
                else{
                    self?.isSuccess.accept(false)
                    self?.errorMessage.accept((res["error_message"] as! String))
                }
                 self?.isLoading.accept(false)
                 }, onError: { [weak self] error in
                     self?.isLoading.accept(false)
                     self?.errorMessage.accept(error.localizedDescription)
                     self?.isSuccess.accept(false)
             }).disposed(by: disposeBag)
     }
    
    func saveUserData(res: [String: Any]){
        if let data = res["data"] as? [String: Any]{
            if let user = data["user"] as? [String: Any]{
                UserDefaults.standard.setValue(user["userName"] as Any, forKey: kUserCache.userName)
                UserDefaults.standard.setValue(user["userId"] as Any, forKey: kUserCache.userId)
                UserDefaults.standard.setValue(user["created_at"] as Any, forKey: kUserCache.created_at)
            }
        }
    }
}

