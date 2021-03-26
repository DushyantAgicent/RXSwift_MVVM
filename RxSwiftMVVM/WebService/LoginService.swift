//
//  LoginService.swift
//  RxSwiftMVVM
//
//  Created by Dushyant Varshney on 26/03/21.
//

import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa

struct LoginService {
    
    var email:String
    var password: String
    
    func execute()->Observable<Any>{
       
        return Observable.create { observer in
            var jsonResult = [String: Any]()
        let parameters = ["email":email,
                          "password":password]
            
            
            
            let url = BASE_URL + kAPIMethods.sign_in
            
            print(url)
            
            var request = URLRequest(url: URL(string: url)!)
            
            request.httpMethod = "POST"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.timeoutInterval = 30
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
 
        print(parameters)
        AF.request(request as URLRequestConvertible).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                if response.response?.statusCode == 200{
                    print(JSON)
                    let res = JSON as! [String: Any]
                    jsonResult = res
                                    
                    observer.onNext(jsonResult)
                }
            case .failure(let error):
           
                observer.onError(error)
            }
        }
            return Disposables.create()
        }
    }
}
