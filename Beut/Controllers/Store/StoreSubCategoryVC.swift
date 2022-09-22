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
        setUpConfigurations()
        
//        self.getCategories()
        if let storeId = storeId {
            getStoreCategories(storeId: storeId)
        }

    }
    
    private func setUpConfigurations(){
        products.register(UINib(nibName: StoreSubCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: StoreSubCategoryCollectionViewCell.identifier)
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
                let selectedIndex = self.segment.indexPathsForVisibleItems[indexPath]
                self.segment.selectItem(at: selectedIndex, animated: true, scrollPosition: [])
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
    
    @objc func addToBasket(sender:UIButton){
        
    }
    
    @objc func incrementQuantity(sender:UIButton){
        
    }
    
    @objc func decrementQuantity(sender:UIButton){
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == segment{
            guard let id = segmentCategories[indexPath.row].categoryId else {return}
            print("ID:\(id)")
            getProductsUsingCategoryId(categoryId: id)
//            print(segmentCategories[indexPath.row])
        }
        
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == segment{
                let width = collectionView.frame.width * 0.5
                let hight = collectionView.frame.height
                       return CGSize(width: width, height: hight)
            }else{
                let width = collectionView.frame.width / 2
                let hight = CGFloat(400)
                       return CGSize(width: width, height: hight)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == segment{
            return 0
        }else{
            return 2
        }
        
    }
    
    
  

    
}
