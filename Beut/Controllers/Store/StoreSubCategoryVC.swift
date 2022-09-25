//
//  StoreSubCategoryVC.swift
//  Beut
//
//  Created by ProjectEgy on 22/09/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class StoreSubCategoryVC: UIViewController {

    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var products: UICollectionView!
    @IBOutlet weak var segment: UICollectionView!
    var storeId:Int?
    var categoryId:Int?
    var productList:[ProductModel] = []
    var segmentCategories:[Categs] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.getCategories()
        if let storeId = storeId {
            getStoreCategories(storeId: storeId)
        }

    }
    
  
    //For segment only
    private func getStoreCategories(storeId:Int){
        let params = ["StoreId":storeId, "lang":"lang".localized] as JSON
        NetworkService.shared.getStoreDetails(parameters:params){
            [weak self] (result) in

            switch result{
            case .success(let data):
                self?.indicator.customIndicator(start: false)
                if let data = data.data{
                    if let categs = data.categories{
                        
                        self?.segmentCategories = categs
                        self?.segment.reloadData()
                        
                        let index = categs.firstIndex { $0.categoryId == self?.categoryId }
        //                self?.segmentCategories = list
                        
                        if let index = index {
                            self?.reloadProductssAndSelect(at: index)
                        }
        
                    }
                }
            case .failure(let error):
//                self?.scrollView.isHidden = false
                self?.indicator.customIndicator(start: false)
                self?.showInofToUser(title: "Error".localized, message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    private func reloadProductssAndSelect(at indexPath:Int){
        segment.reloadData()
        segment.performBatchUpdates(nil, completion:{ [self] (res) in
            if res{
                self.segment.selectItem(at: IndexPath(row: indexPath, section: 0), animated: true, scrollPosition: [])
                guard let id = segmentCategories[indexPath].categoryId else {return}
                self.getProductsUsingCategoryId(categoryId:id)
            }
        })
    }
    
    
    
    private func getProductsUsingCategoryId(categoryId:Int){
       
        products.isHidden = true
        indicator.customIndicator(start: true)
        let params = ["CategoyId":categoryId, "Page":1, "lang":"lang".localized] as [String : Any]
        NetworkService.shared.getProductsByCategoryID(parameters: params) {
            [weak self] (result) in
            
           
            switch result{
            case .success(let data):
                print("Fayed77:\(data)")
                self?.indicator.customIndicator(start: false)
                if let data = data.data{
                    if data.count == 0{
                        self?.products.isHidden = true
                    }else{
                        self?.products.isHidden = false
                        self?.productList = data
                        self?.products.reloadData()
                    }
                   
                }
            case .failure(_):
                self?.indicator.customIndicator(start: false)
            }
        }
    }
}

//Segment
@available(iOS 13.0, *)
extension StoreSubCategoryVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == segment{
            return segmentCategories.count
        }else{
            return productList.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == segment{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as! SegmentCollectionViewCell
            
            cell.setUpCategoryName(name: segmentCategories[indexPath.row].name)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreSubCategoryCollectionViewCell.identifier, for: indexPath) as! StoreSubCategoryCollectionViewCell
            cell.addToBasketBtn.tag = indexPath.row
            cell.plausBtn.tag = indexPath.row
            cell.minusBtn.tag = indexPath.row
            
            cell.addToBasketBtn.addTarget(self, action: #selector(addToBasket(sender:)), for: .touchUpInside)
            
            cell.plausBtn.addTarget(self, action: #selector(incrementQuantity(sender: )), for: .touchUpInside)
            
            cell.minusBtn.addTarget(self, action: #selector(decrementQuantity(sender: )), for: .touchUpInside)
            cell.setUpProduct(product: productList[indexPath.row])
            return cell
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == products{
                let cellSize = CGSize(width: self.view.frame.width * 0.45, height: 300)
                    return cellSize
            }
            else{
                let cellWidth = self.view.frame.width * 0.2
                return CGSize(width: cellWidth, height: collectionView.frame.height)
            }

        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.3
        }
      
    
    
    @objc func decrementQuantity(sender:UIButton){
        let cell = self.products.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! StoreSubCategoryCollectionViewCell
        if cell.quantityValue > 1{
            cell.quantityValue -= 1
        }
        
        cell.quantity.text = "\(cell.quantityValue)"
    }
    
    @objc func incrementQuantity(sender:UIButton){
        let cell = self.products.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! StoreSubCategoryCollectionViewCell
        
        cell.quantityValue += 1
        cell.quantity.text = "\(cell.quantityValue)"
    }
    
    @objc func addToBasket(sender:UIButton){
        if !UserDefaults.standard.isUserLoggedInt{
            UserDefaults.standard.isUserLoggedInt = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
    
            let loginView = storyBoard.instantiateViewController(withIdentifier: "SignIn") as! LogInNavBarViewController
    
            self.present(loginView, animated:true, completion:nil)
        }else{
            guard let productId = productList[sender.tag].productId else {return}
            let cell = self.products.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! StoreSubCategoryCollectionViewCell
            let optionsModifiers = ["Id":0, "Quantity":cell.quantityValue]
            let body = [
                "ProductId":productId,
                "SizeId":-1, // in case that product does not have size, send any number <= 0
                "Quantity":cell.quantityValue,
                "Modifiers":optionsModifiers,
                "Note":"note"
            ] as [String : Any]
            
            self.addItemToBasket(body: body)
        }
    }
    
    private func addItemToBasket(body:JSON){
        self.indicator.customIndicator(start: true, type: .ballTrianglePath)
           
          
            
            NetworkService.shared.addToBasket(body: body){
                [weak self] (result) in
                
                switch result{
                case .success(let data):
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == segment{
            guard let id = segmentCategories[indexPath.row].categoryId else {return}
            print("ID:\(id)")
            getProductsUsingCategoryId(categoryId: id)
//            print(segmentCategories[indexPath.row])
        }
        
    }
        
}
