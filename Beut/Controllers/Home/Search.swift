//
//  Search.swift
//  Esfenja
//
//  Created by ProjectEgy on 24/06/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class Search: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    var searchResults:[ProductModel] = []
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchIndicator: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Search", comment: "search page view")
        navigationItem.backButtonTitle = ""

        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            searchWithText(text:searchText)
        }else{
            self.searchResultsTableView.isHidden = true
        }
    }
}

@available(iOS 13.0, *)
extension Search:UITableViewDelegate, UITableViewDataSource{

    private func searchWithText(text:String){
        self.searchResultsTableView.isHidden = true
        self.searchIndicator.customIndicator(start: true)
        let params = ["filter":text, "lang":"lang".localized, "page":1] as JSON
        NetworkService.shared.search(parameters: params){

            [weak self] (result) in

            switch result{
                case .success(let searchResult):

                if let search = searchResult.data{
                    if search.count > 0{
                        self?.searchResults = search
                        self?.searchResultsTableView.reloadData()
                        self?.searchResultsTableView.isHidden = false
                        self?.searchIndicator.customIndicator(start: false)
                    }else{
                        self?.searchIndicator.customIndicator(start: false)
                        //empty result
                        //Hide tableView, show message to tell user no search result
                    }

                }

            case .failure(let error):
                self?.searchResultsTableView.isHidden = false
                self?.searchIndicator.customIndicator(start: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
        }
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        cell.addToBasket.tag = indexPath.row
        cell.plusBtn.tag = indexPath.row
        cell.minusBtn.tag = indexPath.row
        
        cell.addToBasket.addTarget(self, action: #selector(addToBasket(sender:)), for: .touchUpInside)
        
        cell.plusBtn.addTarget(self, action: #selector(incrementQuantity(sender: )), for: .touchUpInside)
        
        cell.minusBtn.addTarget(self, action: #selector(decrementQuantity(sender: )), for: .touchUpInside)
        cell.setUpSearchResult(result: searchResults[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    @objc func decrementQuantity(sender:UIButton){
        let cell = self.searchResultsTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! SearchTableViewCell
        if cell.quantityValue > 1{
            cell.quantityValue -= 1
        }
        
        cell.quantity.text = "\(cell.quantityValue)"
    }
    
    @objc func incrementQuantity(sender:UIButton){
        let cell = self.searchResultsTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! SearchTableViewCell
        
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
            guard let productId = searchResults[sender.tag].productId else {return}
            let cell = self.searchResultsTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! SearchTableViewCell
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
        self.searchIndicator.customIndicator(start: true, type: .ballTrianglePath)
           
          
            
            NetworkService.shared.addToBasket(body: body){
                [weak self] (result) in
                
                switch result{
                case .success(let data):
                    if data.errorCode == 0{
                        self?.searchIndicator.customIndicator(start: false)
                        self?.showInofToUser(message: "productadd".localized)
                       
                    }else{
                        self?.searchIndicator.customIndicator(start: false)
                        if let message = data.errorMessage{
                            self?.showInofToUser(title: "Error", message: "\(message)")
                        }
                       
                      
                    }
                    case .failure(let error):
                    self?.searchIndicator.customIndicator(start: false)
                    self?.showInofToUser(title: "Error", message: "\(error.localizedDescription)")
                }
            }
    }
    
    
}
