////
////  ItemDetailsViewController.swift
////  Esfenja
////
////  Created by ProjectEgy on 25/07/2022.
////
//
//import UIKit
//import Kingfisher
//import NVActivityIndicatorView
//@available(iOS 13.0, *)
//class ItemDetailsViewController: UIViewController {
//
//    
//    @IBOutlet weak var sizesLabel: UIView!
//    @IBOutlet weak var optionsLabel: UIView!
//    @IBOutlet weak var sizesTableViewHight: NSLayoutConstraint!
//    @IBOutlet weak var sizesTableView: UITableView!
//    @IBOutlet weak var backArrow: UIImageView!
//    @IBOutlet weak var doesHaveOffer: UIImageView!
//    @IBOutlet weak var optionsHight: NSLayoutConstraint!
//    @IBOutlet weak var optionsTableView: UITableView!
//    @IBOutlet weak var basketItemCounter: UILabel!
//    @IBOutlet weak var addToBasketIndicator: NVActivityIndicatorView!
//    static var product:ProductModel?
//    var options :[Options] = []
//    var sizes :[Size] = []
//    var quantityCounter = 1
//    var sizeId = -1
//    var optionId = -1
//    var nav = MyTabBarViewController()
//    @IBOutlet weak var itemImage: UIImageView!
//    @IBOutlet weak var itemOfferPrice: UILabel!
//    @IBOutlet weak var itemOriginalPrice: UILabel!
//    @IBOutlet weak var itemDetails: UILabel!
//    @IBOutlet weak var itemName: UILabel!
//    @IBOutlet weak var quantity: UILabel!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getBasketItemsCount()
//        setUpLanguage()
//        basketItemCounter.isHidden = true
//        optionsTableView.register(UINib(nibName: OpetionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OpetionsTableViewCell.identifier)
//        sizesTableView.register(UINib(nibName: OpetionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OpetionsTableViewCell.identifier)
//        basketItemCounter.masksToBounds = true
//        basketItemCounter.layer.cornerRadius = basketItemCounter.frame.width/2
//        quantity.text = "\(quantityCounter)"
//        setUpItemOptions()
//       
//    }
//    private func setUpLanguage(){
//        let current = Locale.current.languageCode
//        if current == "ar"{
//            backArrow.image = UIImage(named: "arabic_right_arrow")
//        }
//    }
//    private func getBasketItemsCount(){
//        NetworkService.shared.getBasket(parameters: ["lang":"en"]){
//            [weak self] (result) in
//            switch result {
//            case .success(let items):
//                if let items = items.data{
//                    if let i = items.basketItems{
//                        if i.count == 0{
//                            self?.basketItemCounter.isHidden = true
//                        }else{
//                            self?.basketItemCounter.isHidden = false
//                            self?.basketItemCounter.text = "\(i.count)"
//                        }
//                    }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    @IBAction func openBasket(_ sender: Any) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "TabBarNavigator", bundle:nil)
//        BasketViewController.enabled = true
//        let basketView = storyBoard.instantiateViewController(withIdentifier: "BasketNavBar") as! BasketNavBar
//        
//        self.present(basketView, animated:true, completion:nil)
//    }
//
//  
//    @IBAction func incrementQuantity(_ sender: Any) {
//        quantityCounter += 1
//        self.updateQuantity(value: quantityCounter)
//    }
//    @IBAction func goBack(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    @IBAction func decrementQuantity(_ sender: Any) {
//        if quantityCounter > 1{
//            quantityCounter -= 1
//        }
//       
//        updateQuantity(value: quantityCounter)
//    }
//    
//    @IBAction func addToBasket(_ sender: Any) {
//        if !UserDefaults.standard.isUserLoggedInt{
//            UserDefaults.standard.isUserLoggedInt = false
//            let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
//    
//            let loginView = storyBoard.instantiateViewController(withIdentifier: "SignIn") as! LogInNavBarViewController
//    
//            self.present(loginView, animated:true, completion:nil)
//        }else{
//            addItemToBasket()
//        }
//        
//      
//    }
//    
//    func setUpItemOptions(){
//        if let item = ItemDetailsViewController.product{
//            if let isMultiple = item.isMultipleSize, isMultiple == true{
//                
//                guard let sizes = item.sizes else {return}
//                guard let originalPrice = sizes[0].originalPrice else {return}
////                print("Sizes:\(sizes)")
//                itemOriginalPrice.text = originalPrice
//                
//            }else{
//                guard let price = item.singleOriginalPrice else {return}
//                itemOriginalPrice.text = price
//            }
//            
//            if let offerPrice = item.singleOfferPrice, offerPrice != "" {
//                
//                let decimalCharacters = CharacterSet.decimalDigits
//
//                let decimalRange = offerPrice.rangeOfCharacter(from: decimalCharacters)
//
//                if decimalRange != nil {
//                    doesHaveOffer.isHidden = false
//                    itemOfferPrice.isHidden = false
//                    itemOfferPrice.text = offerPrice
//                }else{
//                    doesHaveOffer.isHidden = true
//                    itemOfferPrice.isHidden = true
//                }
//                
//            }else{
//                itemOfferPrice.isHidden = true
//            }
//            
//            if let options = item.optionModifiers{
//                if options.count > 0 {
//                    self.options = options
//                    self.optionsHight.constant = CGFloat(Double(44 * options.count))
//                    optionsTableView.reloadData()
//                }else{
//                    optionsLabel.isHidden = true
//                    optionsTableView.isHidden = true
//                }
//                
//            }
//            itemDetails.text = item.description
//            itemName.text = item.name
//            
//            if let image = item.images{
//                if image.count > 0{
//                let imageUrl = "\(Route.baseUrl)\(image[0])"
//                itemImage.kf.setImage(with:imageUrl.asURL)
//                }
//            }
//            ///Sizes
//            
//            if let isMultiple = item.isMultipleSize, isMultiple == true{
//                
//                guard let sizes = item.sizes else {return}
//                guard let originalPrice = sizes[0].originalPrice else {return}
//                itemOriginalPrice.text = originalPrice
//                
//            }else{
//                guard let price = item.singleOriginalPrice else {return}
//                itemOriginalPrice.text = price
//            }
//            
//            if let offerPrice = item.singleOfferPrice, offerPrice != "" {
//                
//                let decimalCharacters = CharacterSet.decimalDigits
//
//                let decimalRange = offerPrice.rangeOfCharacter(from: decimalCharacters)
//
//                if decimalRange != nil {
//                    doesHaveOffer.isHidden = false
//                    itemOfferPrice.isHidden = false
//                    itemOfferPrice.text = offerPrice
//                }else{
//                    doesHaveOffer.isHidden = true
//                    itemOfferPrice.isHidden = true
//                }
//                
//            }else{
//                itemOfferPrice.isHidden = true
//            }
//            
//            if let sizes = item.sizes{
//                if sizes.count > 0 {
//                    self.sizes = sizes
//                    self.sizesTableViewHight.constant = CGFloat(Double(44 * sizes.count))
//                    self.sizesTableView.reloadData()
//                    
//                }else{
//                    sizesLabel.isHidden = true
//                }
//            }
//        }
//    }
//    
//    private func addItemToBasket(){
//        self.addToBasketIndicator.customIndicator(start: true, type: .ballTrianglePath)
//        if let product = ItemDetailsViewController.product{
//            let optionsModifiers = ["Id":0, "Quantity":quantityCounter]
//            let body = [
//                "ProductId":product.productId!,
//                "SizeId":sizeId, // in case that product does not have size, send any number <= 0
//                "Quantity":quantityCounter,
//                "Modifiers":optionsModifiers,
//                "Note":"note"
//            ] as [String : Any]
//            print("Item Body:\(body)")
//            
//            NetworkService.shared.addToBasket(body: body){
//                [weak self] (result) in
//                
//                switch result{
//                case .success(let data):
//                    print("Data:\(data)")
//                    if data.errorCode == 0{
//                        self?.getBasketItemsCount()
//                        self?.addToBasketIndicator.customIndicator(start: false)
//                        self?.showInofToUser(message: "productadd".localized)
//                       
//                    }else{
//                        self?.addToBasketIndicator.customIndicator(start: false)
//                        if let message = data.errorMessage{
//                            self?.showInofToUser(title: "Error", message: "\(message)")
//                        }
//                       
//                      
//                    }
//                    case .failure(let error):
//                    self?.addToBasketIndicator.customIndicator(start: false)
//                    self?.showInofToUser(title: "Error", message: "\(error.localizedDescription)")
//                }
//            }
//        }
//    }
//    private func updateQuantity(value:Int){
//        if value >= 1{
//            self.quantity.text = "\(value)"
//        }
//        
//    }
//}
//
//@available(iOS 13.0, *)
//extension ItemDetailsViewController:UITableViewDelegate, UITableViewDataSource{
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        if tableView == optionsTableView{
//            return options.count
//        }else{
//            return sizes.count
//        }
//
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == sizesTableView{
//            let cell = tableView.dequeueReusableCell(withIdentifier: OpetionsTableViewCell.identifier) as! OpetionsTableViewCell
//            cell.setUpSizes(size: sizes[indexPath.row])
//            return cell
//            
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: OpetionsTableViewCell.identifier) as! OpetionsTableViewCell
//            cell.setUpOptions(options: options[indexPath.row])
//            return cell
//        }
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == sizesTableView{
//            guard let sizeId = sizes[indexPath.row].sizeId else {return}
//            self.sizeId = sizeId
//        }else if tableView == optionsTableView{
//            guard let optionId = options[indexPath.row].id else {return}
//            self.optionId = optionId
//            self.optionId = optionId
//        }
//        
//    }
//}
