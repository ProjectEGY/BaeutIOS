//
//  Home.swift
//  Esfenja
//
//  Created by ProjectEgy on 24/06/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class Home: UIViewController{
    
    @IBOutlet weak var changeArea: UIBarButtonItem!
    @IBOutlet weak var bellButton: UIBarButtonItem!
    @IBOutlet weak var categoriesTableViewHight: NSLayoutConstraint!
    @IBOutlet weak var categoriesIndecator: NVActivityIndicatorView!
    var resultArray = [String:AnyObject]()
    var gestureRecognizer = UIGestureRecognizer()
    @IBOutlet weak var categoriesTableView: UITableView!
    var categoriesData : [Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for family: String in UIFont.familyNames
//        {
//             print("\(family)")
//             for names: String in   UIFont.fontNames(forFamilyName: family)
//          {
//              print("== \(names)")
//          }
//        }
//        categoriesTableView.estimatedRowHeight = 193
        loadCategories()
        if let areaName = UserDefaults.standard.currentSelectedArea{
            self.changeArea.title! += areaName.localized
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func chageUserArea(_ sender: Any) {
//        tabBarController?.selectedIndex = 1
    }
  
    
    
    private func loadCategories(){
        categoriesIndecator.customIndicator(start: true)
        
        NetworkService.shared.fetchAllCategories{
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                if let data = data.data{
                self?.categoriesData = data
                    self?.categoriesTableViewHight.constant = CGFloat(Double(151 * data.count))
                    self?.categoriesTableView.reloadData()
                self?.categoriesIndecator.customIndicator(start: false)
                }
            case .failure(let error):
                self?.categoriesIndecator.customIndicator(start: false)
                self?.showInofToUser(title: "Error".localized, message: error.localizedDescription)
            }
        }
    }
}

@available(iOS 13.0, *)
extension Home:UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesData.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCategoryTableViewCell.identifier) as! HomeCategoryTableViewCell

        cell.setUpCategory(category: self.categoriesData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 218
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SubCategory", bundle:nil)

        let store = storyBoard.instantiateViewController(withIdentifier: "SubCategoryVC") as! SubCategoryVC
        guard let id = categoriesData[indexPath.row].id else {return}
        store.storeId = id
        self.navigationController?.pushViewController(store, animated: true)
    }
}
