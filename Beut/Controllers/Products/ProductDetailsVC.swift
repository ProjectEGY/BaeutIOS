//
//  ProductDetailsVC.swift
//  Beut
//
//  Created by ProjectEgy on 28/09/2022.
//

import UIKit
import ImageSlideshow
import NVActivityIndicatorView
@available(iOS 13.0, *)
class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var diagonal: UIImageView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sizesTableView: UITableView!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productOriginalPrice: UILabel!
    @IBOutlet weak var productOfferPrice: UILabel!
    @IBOutlet weak var sizesLabel: UILabel!
    @IBOutlet weak var productDetails: UILabel!
    
    var product:ProductModel?
    var sizes:[Size] = []
    var quantity = 1
    var kingfisherImages:[KingfisherSource] = []
    var gestureRecognizer = UIGestureRecognizer()
    var productSizeId = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sizesLabel.text = "   " +  NSLocalizedString("Sizes", comment: "")
        self.sizeView.isHidden = true
        self.sizesTableView.isHidden = true
        self.renderProductInfo()
        self.setUpSlider()
    }
    
    private func setUpSlider(){
        guard let product = product else {
            return
        }
        guard let images = product.images, images.count > 0 else {return}
        for image in images{
                    let imageUrl = "\(Route.baseUrl)\(image)"
                    kingfisherImages.append(KingfisherSource(url: imageUrl.asURL!, placeholder: nil, options: nil))
                }
            
        imageSlider.setImageInputs(kingfisherImages)
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlider.addGestureRecognizer(gestureRecognizer)
        imageSlider.slideshowInterval = 5
//        newSlider.zoomEnabled = true
        imageSlider.pageIndicator!.view.tintColor = .blue
        imageSlider.contentScaleMode = .scaleToFill
        kingfisherImages.removeAll()
    }
    
    @objc func didTap() {
        imageSlider.presentFullScreenController(from: self, completion: nil)
        
    }
    
    private func doesStringHasNumbers(with yourString:String)->Bool{
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = yourString.rangeOfCharacter(from: decimalCharacters)
        if decimalRange != nil {
            return true
        }
        return false
    }
    
    
    private func renderProductInfo(){
        guard let product = product else {return}
        if let name = product.name{
            self.productName.text = name
        }
        if let desc = product.description {
            self.productDetails.text = desc
        }
        
        guard let hasMultipleSize = product.isMultipleSize, hasMultipleSize == true else {
            
            //Here, the product does not have sizes
            if let offerPrice = product.singleOfferPrice, offerPrice != "" {
                if doesStringHasNumbers(with: offerPrice) {
                    diagonal.isHidden = false
                    productOfferPrice.isHidden = false
                    productOfferPrice.text = offerPrice
                }else{
                    diagonal.isHidden = true
                    productOfferPrice.isHidden = true
                }

            }else{
                productOfferPrice.isHidden = true
            }
            guard let original = product.singleOriginalPrice else {return}
                self.productOriginalPrice.text = original
            
            return
            
        }
        

       
            guard let sizes = product.sizes, sizes.count > 0 else {return}
            //Product has multiple sizes
            if let orig = sizes[0].originalPrice{
                self.productOriginalPrice.text = orig
            }
            if let offerPrice = sizes[0].offerPrice, offerPrice != "" {
                
                

                if doesStringHasNumbers(with: offerPrice) {
                    diagonal.isHidden = false
                    productOfferPrice.isHidden = false
                    productOfferPrice.text = offerPrice
                }else{
                    diagonal.isHidden = true
                    productOfferPrice.isHidden = true
                }
                
            }else{
                if let sizeOriginalPrice =  sizes[0].originalPrice {
                    productOriginalPrice.text = sizeOriginalPrice
                }
                productOfferPrice.isHidden = true
            }
  
        //tableview sizes
        if let sizes = product.sizes, sizes.count > 0{
            self.sizes = sizes
            self.tableViewHeight.constant = CGFloat(sizes.count * 46)
            self.sizesTableView.reloadData()
            self.sizesTableView.isHidden = false
            self.sizeView.isHidden = false
        }else{
            self.sizeView.isHidden = true
            self.sizesTableView.isHidden = true
        }
        
        
    }
    
    private func handleOfferPrice(offerPrice:String){
        
    }
    
    private func addItemToBasket(body:JSON){
        print("Body:\(body)")
        self.indicator.customIndicator(start: true, type: .ballTrianglePath)
           
            NetworkService.shared.addToBasket(body: body){
                [weak self] (result) in
                
                switch result{
                case .success(let data):
                    print("OOOOOOOPPPPPPPP \(data)")
                    if data.errorCode == 0{
                        self?.indicator.customIndicator(start: false)
                        self?.showInofToUser(message: "productadd".localized)
                       
                    }else{
                        self?.indicator.customIndicator(start: false)
                        if let message = data.errorMessage{
                            self?.showInofToUser(title: "Error", message: "\(message)")
                        }
                    }
                    case .failure(let error):
                    self?.indicator.customIndicator(start: false)
                    self?.showInofToUser(title: "Error", message: "\(error.localizedDescription)")
                }
            }
    }
    
    
    @IBAction func addToBasket(_ sender: Any) {
        if !UserDefaults.standard.isUserLoggedInt{
            let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
    
            let loginView = storyBoard.instantiateViewController(withIdentifier: "SignIn") as! LogInNavBarViewController
    
            self.present(loginView, animated:true, completion:nil)
        }else{
            guard let product = self.product else {return}
            guard let productId = product.productId else {return}
            let optionsModifiers = ["Id":0, "Quantity":self.quantity]
            let body = [
                "ProductId":productId,
                "SizeId":self.productSizeId, // in case that product does not have size, send any number <= 0
                "Quantity":quantity,
                "Modifiers":optionsModifiers,
                "Note":""
            ] as [String : Any]
            
            self.addItemToBasket(body: body)
        }
    }
    
    
    @IBAction func decrementQuantity(_ sender: Any) {
        if self.quantity > 1{
            self.quantity -= 1
        }
        
        self.productQuantity.text = "\(self.quantity)"
    }
    
    @IBAction func incrementQuantity(_ sender: Any) {
        self.quantity += 1
        self.productQuantity.text = "\(self.quantity)"
    }
    
}
@available(iOS 13.0, *)
extension ProductDetailsVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SizesTableViewCell.identifier) as! SizesTableViewCell
        cell.setUpSize(size: self.sizes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sizeId = sizes[indexPath.row].sizeId else {return}
        self.productSizeId = sizeId
    }
    
    
    
}

@available(iOS 13.0, *)
extension ProductDetailsVC:Presentable{
    
}
