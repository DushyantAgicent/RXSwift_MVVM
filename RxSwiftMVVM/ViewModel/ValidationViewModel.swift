//
//  ValidationViewModel.swift
//  RxSwiftMVVM
//
//  Created by Dushyant Varshney on 26/03/21.
//

import UIKit
import Foundation
import RxRelay
import RxSwift
import RxCocoa

protocol ValidationViewModel {
     
    var errorMessage: String { get }
    
    // Observables
    var data: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get set}
    
    // Validation
    func validateCredentials() -> Bool
}

extension ValidationViewModel {
    func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
    func checkTextSufficientComplexity(_ text : String) -> Bool{


         let capitalLetterRegEx  = ".*[A-Z]+.*"
         let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
         let capitalresult = texttest.evaluate(with: text)
       


         let numberRegEx  = ".*[a-z]+.*" //".*[0-9]+.*"
         let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
         let numberresult = texttest1.evaluate(with: text)
        


         let specialCharacterRegEx  = ".*[0-9]+.*"//".*[!&^%$#@()/]+.*"
         let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)

         let specialresult = texttest2.evaluate(with: text)

         print(capitalresult,numberresult,specialresult)

         return (capitalresult && numberresult && specialresult)

     }
}
