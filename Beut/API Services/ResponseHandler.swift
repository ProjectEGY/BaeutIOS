//
//  ResponseHandler.swift
//  Esfenja
//
//  Created by ProjectEgy on 23/08/2022.
//

import Foundation

@available(iOS 13.0, *)
class ResponseHandler{
    private init(){
        
    }
    
    static let shared = ResponseHandler()
    
    
    
    func handleResponseErrors(response:URLResponse?, error:Error?) ->LocalizedError?{
        
//        if let error = error {
//            if (error as? URLError)?.code == .timedOut {
//                return AppError.timeOut
//            }else{
//                return error as? LocalizedError
//            }
//        }
//        
        
//        guard let response = response else{
//            return AppError.unknownError
//        }
        if let responseStatusCode = response as? HTTPURLResponse{
            if responseStatusCode.statusCode == 503{
                return AppError.serverError("serverError".localized)
            }
        }
        
        return "" as? LocalizedError
    }

    
    func decodeResponse<T: Decodable>(result: Result<Data, Error>?,
                                              completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            return
        }
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            completion(.success(response))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
struct JWT{
    private init(){}
    
    static let shared = JWT()
    
    func getJWT()->String?{
        guard let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key:"userAccountInfo")else{return nil}
        guard let token = result.token else {return nil}
        return token
    }
}

