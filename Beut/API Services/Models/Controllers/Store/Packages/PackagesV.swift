//
//  PackagesViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 17/07/2022.
//

import UIKit
import NVActivityIndicatorView
import Kingfisher
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class PackagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var packagesIndicator: NVActivityIndicatorView!
    var packages:[ProductModel] = []
    @IBOutlet weak var packagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        packagesTableView.dataSource = self
        packagesTableView.delegate = self
        packagesTableView.register(UINib(nibName: Packages.identifier, bundle: nil), forCellReuseIdentifier: Packages.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Packages.identifier) as! Packages
        cell.setUpPackeges(productPakage: packages[indexPath.row])
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Market", bundle:nil)
        
        let orderDetils = storyBoard.instantiateViewController(withIdentifier: "ItemDetailsViewID") as! ItemDetailsViewController
        ItemDetailsViewController.product = packages[indexPath.row]
       
        self.present(orderDetils, animated:true, completion:nil)
    }
    func setUpPackages(storeDetails:StoreDetails)
    {
        
        self.packagesIndicator.customIndicator(start: true)
       
        let params = ["lang":"en", "stopreId":storeDetails.id!, "page":1] as [String:Any]
            NetworkService.shared.getPackages(parameters: params){
                [weak self] (result) in
                switch result{
                case .success(let data):
                    if let data = data.data{
                    self?.packages = data
                    self?.packagesTableView.reloadData()
                    self?.packagesIndicator.customIndicator(start: false)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
