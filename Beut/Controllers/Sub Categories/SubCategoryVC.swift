//
//  SubCategoryVC.swift
//  Beut
//
//  Created by ProjectEgy on 21/09/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class SubCategoryVC: UIViewController {

    var storeId:Int?
    var categories:[SubCategoryModel] = []
    var allCategories:[Categories] = []
    @IBOutlet weak var subCategoriesTableView:UITableView!
    @IBOutlet weak var segment:UICollectionView!
    @IBOutlet weak var indicator:NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConfigurations()
        getCategories()
    }
    
    private func setUpConfigurations(){
        subCategoriesTableView.register(UINib(nibName: SubCategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SubCategoriesTableViewCell.identifier)
    }
    
    
    private func getCategories(){
        NetworkService.shared.fetchAllCategories { [weak self] result in
            switch result{
            case .success(let data):
                guard let list = data.data else {return}

                let index = list.firstIndex { $0.id == self?.storeId }
                self?.allCategories = list
                
                if let index = index {
                   
                    self?.reloadCategoriesAndSelect(at: index)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    
    private func loadStoresUsingCategoryId(categoryId:Int){
       
        subCategoriesTableView.isHidden = true
        indicator.customIndicator(start: true)
        let params = ["CategoryId":categoryId, "Page":1, "lang":"lang".localized] as [String : Any]
        NetworkService.shared.getAllStoresByCategoryID(parameters: params) {
            [weak self] (result) in
            
           
            switch result{
            case .success(let data):
                if let data = data.data{
                    if data.count == 0{
//                        self?.noDataImage.isHidden = false
                        self?.subCategoriesTableView.isHidden = true
                        
                    }
                    self?.subCategoriesTableView.isHidden = false
                    self?.indicator.customIndicator(start: false)
                    self?.categories = data
                   
                    self?.subCategoriesTableView.reloadData()
                }
            case .failure(_):
                self?.indicator.customIndicator(start: false)
            }
        }
    }
    
    private func reloadCategoriesAndSelect(at indexPath:Int){
        segment.reloadData()
        segment.performBatchUpdates(nil, completion:{ [self] (res) in
            if res{
                self.segment.selectItem(at: IndexPath(row: indexPath, section: 0), animated: true, scrollPosition: [])
                guard let id = allCategories[indexPath].id else {return}
                self.loadStoresUsingCategoryId(categoryId:id)
            }
        })
    }



}



@available(iOS 13.0, *)
extension SubCategoryVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as! SegmentCollectionViewCell
        
        cell.setUpCategoryName(name: allCategories[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = allCategories[indexPath.row].id else {return}
        loadStoresUsingCategoryId(categoryId: id)
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width * 0.35
            let hight = collectionView.frame.height
                   return CGSize(width: width, height: hight)
    
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

@available(iOS 13.0, *)
extension SubCategoryVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubCategoriesTableViewCell.identifier) as! SubCategoriesTableViewCell
        cell.setUpSubCategories(category: categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storeId = categories[indexPath.row].id else {return}
        let storyboard = UIStoryboard(name: "Store", bundle: nil)
        let store = storyboard.instantiateViewController(withIdentifier: "Store") as! Store
        store.storeId = storeId
        self.navigationController?.pushViewController(store, animated: true)
    }
    
    
}
