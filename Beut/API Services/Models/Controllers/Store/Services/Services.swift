//
//  ServicesViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 17/07/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class ServicesViewController: UIViewController {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewHight: NSLayoutConstraint!
    @IBOutlet weak var servicesIndicator: NVActivityIndicatorView!
    @IBOutlet weak var noDataView: UIView!
    var storeServices:[Categs] = []
    var producsByCategoryId:[ProductModel] = []
    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTableView.register(UINib(nibName: Packages.identifier, bundle: nil), forCellReuseIdentifier: Packages.identifier)
      
    }
    func setUpServices(storeInfo:StoreDetails){
        
        if let value = storeInfo.categories{
            storeServices = value
            reloadCategoriesAndSelectFirstOne()
            if value.count == 0 {
                noDataView.isHidden = false
                scrollView.isHidden = true
            }
        }
    }
    private func getProductsByCategoryID(categoryId:Int){
        noDataView.isHidden = true
        scrollView.isHidden = false
        servicesIndicator.customIndicator(start: true)
        let params = ["CategoyId":categoryId, "lang":"en"] as [String : Any]
        NetworkService.shared.getProductsByCategoryID(parameters: params) {
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                if let data = data.data{
                self?.tableViewHight.constant = CGFloat(Double(242 * data.count))
                self?.producsByCategoryId = data
                self?.productsTableView.reloadData()
                self?.servicesIndicator.customIndicator(start: false)
                }
            case .failure(let error):
                self?.servicesIndicator.customIndicator(start: false)
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func reloadCategoriesAndSelectFirstOne(){
        categoriesCollectionView.reloadData()
        categoriesCollectionView.performBatchUpdates(nil, completion:{ [self] (res) in
            if res{
                if categoriesCollectionView.indexPathsForVisibleItems.count > 0{
                    let selectedIndex = self.categoriesCollectionView.indexPathsForVisibleItems[0]
                    self.categoriesCollectionView.selectItem(at: selectedIndex, animated: true, scrollPosition: [])
                    self.getProductsByCategoryID(categoryId:storeServices[0].categoryId!)
                }
                
            }
        })
    }

}

@available(iOS 13.0, *)
extension ServicesViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeServices.count
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCategoryCollectionViewCell.identifier, for: indexPath) as! StoreCategoryCollectionViewCell
        cell.setUpStoreCategories(storeCategories: storeServices[indexPath.row])
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getProductsByCategoryID(categoryId: storeServices[indexPath.row].categoryId!)
    }
}

@available(iOS 13.0, *)
extension ServicesViewController:UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        producsByCategoryId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Packages.identifier) as! Packages
        cell.setUpPackeges(productPakage: producsByCategoryId[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Market", bundle:nil)
        
        let orderDetils = storyBoard.instantiateViewController(withIdentifier: "ItemDetailsViewID") as! ItemDetailsViewController
        ItemDetailsViewController.product = producsByCategoryId[indexPath.row]
       
        self.present(orderDetils, animated:true, completion:nil)
    }
}
