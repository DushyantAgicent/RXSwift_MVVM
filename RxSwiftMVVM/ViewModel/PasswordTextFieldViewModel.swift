//
//  PasswordTextFieldViewModel.swift
//  RxSwiftMVVM
//
//  Created by Dushyant Varshney on 26/03/21.
//

import RxSwift
import RxCocoa


protocol VSSecureFieldViewModel {
    var isSecureTextEntry: Bool { get }
}

class PasswordTextFieldViewModel:ValidationViewModel{



   var data: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
   var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
   
   let errorMessage = "Password require at least 1 uppercase, 1 lowercase, and 1 number."
   
   var isSecureTextEntry: Bool = true
   
    func validateCredentials() -> Bool {
        guard validateSize(data.value, size: (3,16)) && checkTextSufficientComplexity(data.value) else {
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
    }

}
