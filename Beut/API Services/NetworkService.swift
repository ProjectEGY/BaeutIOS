//
//  NetworkService.swift
//  Esfenja
//
//  Created by ProjectEgy on 03/07/2022.
//

import Foundation

@available(iOS 13.0, *)
struct NetworkService {
    
    static let shared = NetworkService()
    private init() {
        
    }
    
    func fetchAllCategories(completion: @escaping(Result<GeneralResponse<[Categories]>, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, parameters:["lang":"lang".localized], completion: completion)
    }
    
    func fetchSliderData(completion: @escaping(Result<GeneralResponse<Slider>, Error>) -> Void) {
        request(route: .getSliderData, method: .get, completion: completion)
    }
    
    func logIn(parameters: JSON?, completion: @escaping(Result<GeneralResponse<User>, Error>) -> Void){
        request(route: .logIn, method: .post, parameters:parameters, completion: completion)
        
    }

    func getStoreDetails(parameters: JSON?, completion: @escaping(Result<GeneralResponse<StoreDetails>, Error>) -> Void){
        request(route: .storeDetails, method: .get, parameters: parameters, completion: completion)
    }
    
    func getAllStoresByCategoryID(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[SubCategoryModel]>, Error>) -> Void){
        request(route: .getAllStoresByCategoryID, method: .get,parameters: parameters, completion: completion)
    }
    
    func getPackages(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[ProductModel]>, Error>) -> Void){
        request(route: .getPackages, method: .get,parameters: parameters, completion: completion)
        
    }
    
    func getProductsByCategoryID(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[ProductModel]>, Error>) -> Void){
        request(route: .getProductByCategoryID, method: .get,parameters: parameters, completion: completion)
        
    }
    
    func addToBasket(body:JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .addToBasket, method: .post,parameters: body,
                isAuthorizedRequest:true,
                completion: completion)
        
    }
    
    
    func signUp(parameters: JSON?, completion: @escaping(Result<GeneralResponse<User>, Error>) -> Void){
        request(route: .signUp, method: .post,parameters: parameters, completion: completion)
        
    }
    
    func verfiyAccount(parameters: JSON?, completion: @escaping(Result<GeneralResponse<User>, Error>) -> Void){
        request(route: .verifyAccount, method: .post,parameters: parameters, completion: completion)
        
    }

    func getBasket(parameters: JSON?, completion: @escaping(Result<GeneralResponse<Basket>, Error>) -> Void){
        request(route: .getBasket, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
        
    }

    func removeBasketItemWithItemID(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
            request(route: .removeBasketItem, method: .delete,parameters: parameters, isAuthorizedRequest:true, completion: completion)
    }
    
    func decreaseBasketItem(parameters: JSON?, completion: @escaping(Result<GeneralResponse<Deta>, Error>) -> Void){
        request(route: .decreaseItem, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func increaseBasketItem(parameters: JSON?, completion: @escaping(Result<GeneralResponse<Deta>, Error>) -> Void){
        request(route: .increaseItem, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func checkOut(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .checkOut, method: .post,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }

    func addNewAddress(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .addNewAddress, method: .post,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func saveAddressToOrder(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .saveAddressToOrder, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    func getPreviousOrders(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[Orders]>, Error>) -> Void){
        request(route: .previousOrders, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func getCurrentOrders(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[Orders]>, Error>) -> Void){
        request(route: .currentOrders, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func getOrderDetails(parameters: JSON?, completion: @escaping(Result<GeneralResponse<OrderDetails>, Error>) -> Void){
        request(route: .orderDetails, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func search(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[SearchResult]>, Error>) -> Void){
        request(route: .search, method: .get,parameters: parameters,
                completion: completion)
    }
    
    func changePassword(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .changePassword, method: .post,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func sendComplaints(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .complaints, method: .post,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    func selectCountryAndCity(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[Country]>, Error>) -> Void){
        request(route: .changeCity, method: .get,parameters: parameters,
                completion: completion)
    }
    
    func getNotifications(parameters: JSON?, completion: @escaping(Result<GeneralResponse<[UserNotification]>, Error>) -> Void){
        request(route: .pushNotifications, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
  
    func updateProfile(parameters: JSON?, completion: @escaping(Result<GeneralResponse<User>, Error>) -> Void){
        request(route: .updateProfile, method: .put,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }

    func getCashPoints(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .getCashPoints, method: .get,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    func forgetPassword(parameters: JSON?, completion: @escaping(Result<GeneralResponse<String>, Error>) -> Void){
        request(route: .forgetPassword, method: .post,parameters: parameters,
                isAuthorizedRequest:true,
                completion: completion)
    }
    
    
    /// This function helps us to send request to the server
    /// - Parameters:
    ///   - route: the path the the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
        private func request<T: Decodable>(route: Route,
                                     method: Method,
                                     parameters: JSON? = nil,
                                       isAuthorizedRequest:Bool? = false,
                                     completion: @escaping(Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, isAuthorizedRequest:isAuthorizedRequest, parameters: parameters) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
//            if let data = data {
//                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
//                    print("The response is:\n\(responseString)")
//            }
         
 
            if let errorStatus = ResponseHandler.shared.handleResponseErrors(response: response, error: error){
                result = .failure(errorStatus)
            }else{
                if let error = error {
                    result = .failure(error)
                }
            }
            
            if let data = data {
                result = .success(data)
            }
            
            DispatchQueue.main.async {
                ResponseHandler.shared.decodeResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    /// This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: the path the the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    func createRequest(route: Route,
                       method: Method,
                       isAuthorizedRequest:Bool? = false,
                       parameters: JSON? = nil) -> URLRequest? {
        
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asURL else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let result = UserDefaults.standard.readCurrentUserLocation(key: "currentUserLocation"){
            if let longitude = result.longitude, let latitude = result.latitude{
                urlRequest.addValue("\(longitude)", forHTTPHeaderField: "longitude")
                urlRequest.addValue("\(latitude)", forHTTPHeaderField: "latitude")
            }else{
                urlRequest.addValue("-0.1337", forHTTPHeaderField: "longitude")
                urlRequest.addValue("51.50998", forHTTPHeaderField: "latitude")            }
        }
        if let aredId = UserDefaults.standard.areaId{
            urlRequest.addValue("\(aredId)", forHTTPHeaderField: "areaId")
        }else{
            urlRequest.addValue("\(-1)", forHTTPHeaderField: "areaId")
        }
        
        if isAuthorizedRequest!{
            if let token = JWT.shared.getJWT() {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        
        urlRequest.httpMethod = method.rawValue
        if let params = parameters {
            switch method {
            case .get, .delete:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
             
            case .post, .patch, .put:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
