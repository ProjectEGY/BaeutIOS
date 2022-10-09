//
//  Basket.swift
//  Esfenja
//
//  Created by ProjectEgy on 15/07/2022.
//

import UIKit
import NVActivityIndicatorView
import AARatingBar
import CoreLocation
import Kingfisher
@available(iOS 13.0, *)
class BasketViewController: UIViewController, UITabBarControllerDelegate {

    //Store View
    @IBOutlet weak var storeRate: AARatingBar!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeSeenCount: UILabel!
    @IBOutlet weak var storeImage: UIImageView!
    
    @IBOutlet weak var storeDescription: UILabel!
//    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var notes: CustomForComplaints!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var emptyCardView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewHight: NSLayoutConstraint!

    @IBOutlet weak var creditCardRadioButton: UIImageView!
    @IBOutlet weak var cashRadioButton: UIImageView!
    @IBOutlet weak var walletRadioButton: UIImageView!
    
    @IBOutlet weak var orderNowRadioButton: UIImageView!
    @IBOutlet weak var orderLaterRadioButton: UIImageView!
    
    @IBOutlet weak var orderLater: UIDatePicker!
    
    var orderNow = true
    var ordeRLater = false
    
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var deliveryFees: UILabel!
    @IBOutlet weak var total: UILabel!
    
    static var enabled = false
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    
    var isCredit = false
    var isWallet = false
    var isCash = false
    
    var isOrderNow = false
    var isOrderLater = false
    var myBasket:Basket?
    var basketItems:[BasketItem] = []
    
    @IBOutlet weak var basketItemsTableView: UITableView!
    @IBOutlet weak var bsketIndicator: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.selectedIndex = 2
        title = "Basket".localized
        basketItemsTableView.register(UINib(nibName: BasketItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BasketItemTableViewCell.identifier)
        self.loadBasket()
        
//        if LocalizationManager.shared.getLanguage() == .Arabic{
//            backButton.image = UIImage(named: "back_arrow_arabic")
//        }
//        setUpViewConfigurations()
//        if !BasketViewController.enabled{
//            backButton.isEnabled = false
//            backButton.tintColor = .white
//        }else{
//            backButton.isEnabled = true
//            backButton.tintColor = .black
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViewConfigurations()
    }
    /// set up initial configurations
    private func setUpViewConfigurations(){
            creditCardRadioButton.image = UIImage(named: "selected")
            cashRadioButton.image = UIImage(named: "circle")
            walletRadioButton.image = UIImage(named: "circle")
            
            isCredit = true
            isWallet = false
            isCash = false
            
            orderNowRadioButton.image = UIImage(named: "selected")
            orderLaterRadioButton.image = UIImage(named: "circle")
            
            isOrderNow = true
            isOrderLater = false
            
            setUpEmptyCard(isEmpty: true)
            self.loadBasket()
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        BasketViewController.enabled = false
    }
//    @IBAction func applyPoints(_ sender: Any) {
//        if let points = userPointsTextField.text{
//
//            if points == ""{
//                self.showInofToUser(message: "Enter point value")
//            }else{
//                self.bsketIndicator.customIndicator(start: true, type: .ballTrianglePath)
//                self.makeViewInVisible(wannaMakeItVisible: true)
//                NetworkService.shared.getCashPoints(parameters: ["point":points] as [String:Any]){
//                    [weak self] (result) in
//                    switch result{
//                    case .success(let data):
//                        self?.pointsInfo.isHidden = false
//                        self?.pointsInfo.text = data.data!
//                        self?.bsketIndicator.customIndicator(start: false)
//                        self?.makeViewInVisible(wannaMakeItVisible: false)
//
//                    case .failure(let error):
//                        self?.bsketIndicator.customIndicator(start: false)
//                        self?.makeViewInVisible(wannaMakeItVisible: false)
//                        self?.showInofToUser(title: "Error", message: error.localizedDescription)
//                    }
//                }
//            }
//        }
//
//    }
    
    @IBAction func orderLater(_ sender: Any) {
        isOrderNow = false
        isOrderLater = true
        orderLater.isHidden = false
        orderLaterRadioButton.image = UIImage(named: "selected")
        orderNowRadioButton.image = UIImage(named: "circle")
    }
    
    @IBAction func orderNow(_ sender: Any) {
        isOrderNow = true
        isOrderLater = false
        orderLater.isHidden = true
        orderLaterRadioButton.image = UIImage(named: "circle")
        orderNowRadioButton.image = UIImage(named: "selected")
    }
    
    @IBAction func creditCard(_ sender: Any) {
        isCash = false
        isWallet = false
        isCredit = true
        creditCardRadioButton.image = UIImage(named: "selected")
        orderLater.isHidden = true
        walletRadioButton.image = UIImage(named: "circle")
        cashRadioButton.image = UIImage(named: "circle")
        
    }
    
    @IBAction func wallet(_ sender: Any) {
        isCash = false
        isWallet = true
        isCredit = false
        creditCardRadioButton.image = UIImage(named: "circle")
        orderLater.isHidden = true
        walletRadioButton.image = UIImage(named: "selected")
        cashRadioButton.image = UIImage(named: "circle")
    }
    
    @IBAction func cash(_ sender: Any) {
        isCash = true
        isWallet = false
        isCredit = false
        creditCardRadioButton.image = UIImage(named: "circle")
        orderLater.isHidden = true
        walletRadioButton.image = UIImage(named: "circle")
        cashRadioButton.image = UIImage(named: "selected")
    }
    
    @IBAction func order(_ sender: Any) {
        orderFromBasket()
//        if isCredit{
//            self.showInofToUser(message: "CreditNotProvidedYet".localized)
//        }else{
//
//        }
        
    }
    
    private func orderFromBasket(){
        
        var body = ["UserAddressId":88, // in case that order does not have address, else send null
                    "PaymentMethod":1, // 0 Cash - 1 Online,
                    "Note":"helloworld",
                    "Now": isOrderNow,
                    "DayMonthYear": "Hmmm",
                    "Time":"TimeHmm",
                    "point":20] as [String:Any]
        if let notes = self.notes.text, notes != ""{
            body["Note"] = notes
        }

        if isOrderLater{
            body["DayMonthYear"] = orderLater.date.dateAsString()
            body["Time"] = orderLater.date.timeAsString()
        }
        if isCredit{
            body["PaymentMethod"] = 1
        } else if isCash{
            body["PaymentMethod"] = 0
        }
        else if isWallet{
            body["PaymentMethod"] = 2
        }

        if let myBasket = myBasket {
                //send checkout request
                body["UserAddressId"] = myBasket.userAddress?.id
                self.checkOut(body:body)
            
        }
    }
    
    @IBAction func addNewAddress(_ sender: Any) {
    }
    
    private func setUpEmptyCard(isEmpty:Bool){

            self.scrollView.isHidden = isEmpty
            emptyCardView.isHidden = !isEmpty
            orderButton.isHidden = isEmpty
    }
    /// If current basket does not have a user address, we assign a new address to the basket based on cureent user location
    private func addNewAddress(){
        if let cuurentLocation = LocationManger.shared.getCurrentLocationForUser(){
            var params = [
                "Id":0,
                "Name":"",
                "Latitude":cuurentLocation.latitude!,
                "Longitude":cuurentLocation.longitude!,
                "Address":"Egypt",
                "Floor":"",
                "BuildingNumber":"",
                "Apartment":"",
                "PhoneNumber":"",
                "AddressInDetails":""] as [String : Any]
            
            var fullAddress = ""
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: cuurentLocation.latitude!, longitude: cuurentLocation.longitude!)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                // Country
                if let country = placeMark.country {
                    fullAddress += country + ", "
                }
                // City
                if let city = placeMark.locality {
                    fullAddress += city + ", "
                }
                // Street address
                if let street = placeMark.thoroughfare {
                    fullAddress += street
                }
  
                params["Address"] = fullAddress
                
                
            if let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key:"userAccountInfo"){
                params["Name"] = result.name!
                params["PhoneNumber"] = result.phone!
            }
                NetworkService.shared.addNewAddress(parameters: params){
                    [weak self] (result) in
                    
                    switch result{
                    case .success(_):
                        self?.saveAddressToOrder()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
               
            })
            
     
        }
    }
    private func saveAddressToOrder(){
        let params = ["IsStoreOrder":true] as [String:Any]
        NetworkService.shared.saveAddressToOrder(parameters: params){
            (result) in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    /// Check out the order
    /// - Parameter body: body contains info related to order such as payment options and ordering time
    private func checkOut(body:[String:Any]){
        self.bsketIndicator.customIndicator(start: true, type:.ballTrianglePath)
        NetworkService.shared.checkOut(parameters: body){
           
            [weak self] (result) in
           
            switch result{
            case .success(let data):
                if data.errorCode == 0{
                    self?.bsketIndicator.customIndicator(start: false)
                    let pay = body["PaymentMethod"] as! Int
                    switch pay{
                    case 0:
                        self?.showInofToUser(message:"AddedSuccessfully".localized)
                    case 1:
                        let storyboard = UIStoryboard(name: "TermsAndConditions", bundle: nil)
                        let paymentView = storyboard.instantiateViewController(withIdentifier: "OnlinePaymentVC") as! OnlinePaymentVC
                        if let url = data.data{
                            paymentView.paymentURL = url
                            self?.navigationController?.pushViewController(paymentView, animated: true)
                        }
                        
                        
                    case 2:
                        if let errorMessage = data.errorMessage{
                            self?.showInofToUser(message:errorMessage)
                        }
                        
                    default:
                        print("")
                    }
                    
                }else{
                    if let message = data.errorMessage{
                        self?.showInofToUser(title: "Error", message: message)
                    }
                    self?.bsketIndicator.customIndicator(start: false)
                }
            case .failure(let error):
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
                self?.bsketIndicator.customIndicator(start: false)
            }
        }

    }
    /// This funcion shows info related to user such as address, name and points
    /// - Parameter basket: basket has a user address, so we extract and show it
    private func setUpUserInfo(basket:Basket){
        self.userName.text = basket.userAddress?.name
        self.userAddress.text = basket.userAddress?.address
        self.userPhone.text = basket.userAddress?.phoneNumber
    }
    
    /// Show order details such as subtotal, delivery fess and total cost
    /// - Parameter basket: basket has the order details
    private func setUpOrderInfo(basket:Basket){
        self.subTotal.text = basket.subTotal
        self.deliveryFees.text = basket.deliveryFees
        self.total.text = basket.total
    }
    
}


@available(iOS 13.0, *)
extension BasketViewController{
    
    /// Load user basket using api
     func loadBasket(){
        if UserDefaults.standard.isUserLoggedInt{
        self.bsketIndicator.customIndicator(start: true)
            emptyCardView.isHidden = true
            NetworkService.shared.getBasket(parameters: ["lang":"lang".localized]){
                [weak self] (result) in
                
                switch result{
                    
                case .success(let basket):
                    
                    if let basket = basket.data{
                        self?.setUpStoreView(basket: basket)
                        if !basket.customerHasAddress!{
                            self?.addNewAddress()
                            self?.loadBasket()
                        }
                        else{
                            
                            self?.basketItems = basket.basketItems!
                            self?.myBasket = basket
                            self?.basketItemsTableView.reloadData()
                            self?.tableViewHight.constant = CGFloat(Double(148 * basket.basketItems!.count))
                            
        //                    self?.view.alpha = 1
                            self?.setUpUserInfo(basket: basket)
                            self?.setUpOrderInfo(basket: basket)
                            
                            self?.bsketIndicator.customIndicator(start: false)
                           
                            self?.setUpEmptyCard(isEmpty: false)
                            }
                        
                            self?.bsketIndicator.customIndicator(start: false)
                    }else{
                        
                        self?.bsketIndicator.customIndicator(start: false)
                        self?.setUpEmptyCard(isEmpty: true)
                    }
                    
                case.failure(let error):
                    self?.bsketIndicator.customIndicator(start: false)
//                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.showInofToUser(title: "Error", message: error.localizedDescription)
                }
            }
        }
       
     }
    private func setUpStoreView(basket:Basket){
        if let storeName = basket.name{
            self.storeName.text = storeName
        }
        if let desc = basket.basketDescription{
            self.storeDescription.text = desc
        }else{
            self.storeDescription.isHidden = true
        }
        
        if let seenCount = basket.seenCount {
            self.storeSeenCount.text = "\(seenCount)"
        }
        if let image = basket.logoImageURL{
            let url = "\(Route.baseUrl)\(image)"
            self.storeImage.kf.setImage(with:url.asURL)
        }
    }
    /// Increament the amount of a specific item
    /// - Parameter basketItemId: the id of the item we wanna increment
    private func decreaseBasketItem(basketItemId:Int){
        if basketItems[basketItemId].quantity! == 1{
            self.showInofToUser(title: "Error".localized, message: "MinimumQuantity".localized)
        }else{
        bsketIndicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        let params = ["BasketItemId":basketItems[basketItemId].basketItemID!] as [String:Any]
        NetworkService.shared.decreaseBasketItem(parameters: params){
            [weak self] (result) in
            
            switch result{
            case .success(_):
                    self?.bsketIndicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.loadBasket()
            case .failure(let error):
                self?.bsketIndicator.customIndicator(start: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                }
            }
        }
    }
    
    /// decrease the amount of a specific item
    /// - Parameter basketItemId: the id of the item we wanna decrement
    private func increaseBasketItem(basketItemId:Int){
        bsketIndicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        let params = ["BasketItemId":basketItemId] as [String:Any]
        NetworkService.shared.increaseBasketItem(parameters: params){
            [weak self] (result) in
            
            switch result{
            case .success(_):
                self?.bsketIndicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.loadBasket()
            case .failure(let error):
                self?.bsketIndicator.customIndicator(start: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
                self?.makeViewInVisible(wannaMakeItVisible: false)
            }
        }
    }
    
    /// Remove an item from our basket order
    /// - Parameter itemID: the id of the item we wanna remove
    private func removeItemFromBaketWithItemID(itemID:Int){
        bsketIndicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        let params = ["BasketItemId":itemID] as [String:Any]
            NetworkService.shared.removeBasketItemWithItemID(parameters: params){
                [weak self] (result) in
                
                switch result{
                case .success(_):
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.bsketIndicator.customIndicator(start: false)
                    self?.loadBasket()
                case .failure(let error):
                    self?.bsketIndicator.customIndicator(start: false)
                    self?.showInofToUser(title: "Error", message: error.localizedDescription)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                }
        }
    }
}

@available(iOS 13.0, *)

extension BasketViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketItemTableViewCell.identifier) as! BasketItemTableViewCell
        cell.deleteButton.tag = basketItems[indexPath.row].basketItemID!
        cell.deleteButton.addTarget(self, action: #selector(removeItemFromBasket(sender:)), for:.touchUpInside)
        
        cell.incrementItemButton.tag = basketItems[indexPath.row].basketItemID!
        cell.incrementItemButton.addTarget(self, action: #selector(incrementQuantity(sender:)), for:.touchUpInside)
        
        cell.decrementItemButton.tag = indexPath.row
        
        cell.decrementItemButton.addTarget(self, action: #selector(decrementQuantity(sender:)), for:.touchUpInside)
        
        cell.setUpBasketItems(basketItem: basketItems[indexPath.row])
        return cell
    }
    
    @objc func removeItemFromBasket(sender :UIButton){
        if basketItems.count == 1{
            scrollView.isHidden = true
            bsketIndicator.customIndicator(start: false)
            basketItems = []
            basketItemsTableView.reloadData()
            emptyCardView.isHidden = false
        }
        removeItemFromBaketWithItemID(itemID: sender.tag)
    }
    
    @objc func incrementQuantity(sender :UIButton){
        increaseBasketItem(basketItemId: sender.tag)
    }
    
    @objc func decrementQuantity(sender :UIButton){
        decreaseBasketItem(basketItemId: sender.tag)
        
    }
}
