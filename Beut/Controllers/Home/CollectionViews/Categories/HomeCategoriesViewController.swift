////
////  HomeCategoriesViewController.swift
////  Esfenja
////
////  Created by ProjectEgy on 19/07/2022.
////
//
//import UIKit
//
//class HomeCategoriesViewController: UIViewController {
//    var categoriesData : [Categories] = []
//    @IBOutlet weak var categoriesCollectionView: UICollectionView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadCategories()
//        // Do any additional setup after loading the view.
//    }
//    
//
//
//}
//extension HomeCategoriesViewController:UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categoriesData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
//        cell2.setUpHomeCategories(homwCategories: categoriesData[indexPath.row])
//        return cell2
//    }
//    
//    
//    private func loadCategories(){
//        categoriesIndecator.isHidden = false
////        categoriesIndecator.setUpIndicator(start: true)
//        
//        NetworkService.shared.fetchAllCategories{
//            [weak self] (result) in
//            
//            switch result{
//            case .success(let data):
//                self?.categoriesData = data
//                self?.categoriesCollectionView.reloadData()
////                self?.categoriesIndecator.setUpIndicator(start: false)
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        storeCategoriesIndicator.setUpIndicator(start: true)
//        print( categoriesData[indexPath.row])
//        let currentStoreCategoryID = categoriesData[indexPath.row].id
//        let params = ["CategoryId":currentStoreCategoryID, "Page":1, "lang":"en"] as [String : Any]
//        NetworkService.shared.getAllStoresByCategoryID(parameters: params) {
//            [weak self] (result) in
//            
//           
//            switch result{
//            case .success(let data):
//                self?.storeCategoriesIndicator.setUpIndicator(start: false)
//                self?.storeCategory = data
//                self?.categoriesTableView.reloadData()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//}
