//
//  EmailViewModel.swift
//  RxSwiftMVVM
//
//  Created by Dushyant Varshney on 26/03/21.
//

import RxSwift
import RxCocoa


class EmailViewModel:ValidationViewModel{


    var errorMessage: String = "This is a invalid email."

    var data: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)

    func validateCredentials() -> Bool {
        
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        guard validateString(data.value, pattern: emailPattern) else{
            self.errorValue.accept(errorMessage)
            return false;
        }
              
         errorValue.accept(nil)
         return true
    }

}



