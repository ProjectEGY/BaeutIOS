//
//  Market.swift
//  Esfenja
//
//  Created by ProjectEgy on 05/07/2022.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
import AARatingBar
@available(iOS 13.0, *)
class Store: UIViewController{
    @IBOutlet weak var storeDescription: UILabel!
    @IBOutlet weak var storeIndicator: NVActivityIndicatorView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeSeenCount: UILabel!
    @IBOutlet weak var storeRate: AARatingBar!
    @IBOutlet weak var storeLogoImage: UIImageView!
    @IBOutlet weak var storeCategories: UICollectionView!
    
    var storeId:Int?
    var storeCategoriesList :[Categs] = []
    var myTab = MyTabBarViewController()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let value = storeId{
            getStoreDetails(storeId: value)
        }
    }
//
//    private func setUpLanguage(){
//        let current = Locale.current.languageCode
//        if current == "ar"{
//            backarrow.image = UIImage(named: "arabic_right_arrow")
//        }
//    }
    
    @IBAction func openBasket(_ sender: Any) {
//        myTab.selectedIndex = 2
        let storyBoard : UIStoryboard = UIStoryboard(name: "TabBarNavigator", bundle:nil)
//        BasketViewController.enabled = true
        let basketView = storyBoard.instantiateViewController(withIdentifier: "BasketID") as! BasketViewController

        self.navigationController?.pushViewController(basketView, animated: true)
    }
    
    
 
    
    private func getStoreDetails(storeId:Int){
        let params = ["StoreId":storeId, "lang":"lang".localized] as JSON
        NetworkService.shared.getStoreDetails(parameters:params){
            [weak self] (result) in

            switch result{
            case .success(let data):
                
                self?.storeIndicator.customIndicator(start: false)
                if let data = data.data{
                    self?.setUpStoreDetails(storeDetials: data)
                }
            case .failure(let error):
//                self?.scrollView.isHidden = false
                self?.storeIndicator.customIndicator(start: false)
                self?.showInofToUser(title: "Error".localized, message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    func setUpStoreDetails(storeDetials:StoreDetails){
        if let list = storeDetials.categories {
            self.storeCategoriesList = list
            self.storeCategories.reloadData()
        }
        if let image = storeDetials.logoImageUrl{
            let logoImageUrl = "\(Route.baseUrl)\(image)"
            self.storeLogoImage.kf.setImage(with: logoImageUrl.asURL)
        }
        if let name = storeDetials.name{
            self.storeName.text = name
        }
//        storeRate.text = stoDet.rate!
        if let count = storeDetials.seenCount{
            storeSeenCount.text = "\(count)"
        }
        
        if let des = storeDetials.description{
            storeDescription.text = des
        }else{
            storeDescription.isHidden = true
        }
        
        if let rate = storeDetials.rate{
            if let num = Float(rate){
                self.storeRate.value = CGFloat(num)
                if num > 0{
                    self.storeRate.color = .systemYellow
                }else{
                    self.storeRate.color = .gray
                }
            }
        }
        
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
}
@available(iOS 13.0, *)
extension Store:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeCategoriesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCategoriesCollectionViewCell", for: indexPath) as! StoreCategoriesCollectionViewCell
        cell.setUpStoreCategories(category: storeCategoriesList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "StoreCategoy", bundle: nil)
        let storeSubCategory = storyboard.instantiateViewController(withIdentifier: "StoreSubCategoryVC") as! StoreSubCategoryVC
        storeSubCategory.storeId = self.storeId
        storeSubCategory.categoryId = storeCategoriesList[indexPath.row].categoryId
        self.navigationController?.pushViewController(storeSubCategory, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        let cellSize = CGSize(width: self.view.frame.width * 0.3, height: 150)
            return cellSize

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }

}
