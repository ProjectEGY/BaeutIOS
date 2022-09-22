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

    var searchResults:[SearchResult] = []
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchIndicator: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Search", comment: "search page view")
        navigationItem.backButtonTitle = ""

//        searchResultsTableView.register(UINib(nibName: StoreCategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: StoreCategoryTableViewCell.identifier)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
//            searchWithText(text:searchText)
        }else{
            self.searchResultsTableView.isHidden = true
        }
    }
}
//
//@available(iOS 13.0, *)
//extension Search:UITableViewDelegate, UITableViewDataSource{
//
//    private func searchWithText(text:String){
//        self.searchResultsTableView.isHidden = true
//        self.searchIndicator.customIndicator(start: true)
//        let params = ["searchText":text]
//        NetworkService.shared.search(parameters: params){
//
//            [weak self] (result) in
//
//            switch result{
//                case .success(let searchResult):
//
//                if let search = searchResult.data{
//                    if search.count > 0{
//                        self?.searchResults = search
//                        self?.searchResultsTableView.reloadData()
//                        self?.searchResultsTableView.isHidden = false
//                        self?.searchIndicator.customIndicator(start: false)
//                    }else{
//                        self?.searchIndicator.customIndicator(start: false)
//                        //empty result
//                        //Hide tableView, show message to tell user no search result
//                    }
//
//                }
//
//            case .failure(let error):
//                self?.searchResultsTableView.isHidden = false
//                self?.searchIndicator.customIndicator(start: false)
//                self?.showInofToUser(title: "Error", message: error.localizedDescription)
//        }
//    }
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        searchResults.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: StoreCategoryTableViewCell.identifier) as! StoreCategoryTableViewCell
//        cell.setStoreSearchResult(searchResult: searchResults[indexPath.row])
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Market", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "StoreID") as! Store
//        nextViewController.storeId = searchResults[indexPath.row].id
//        self.present(nextViewController, animated:true, completion:nil)
//    }
//
//
//}
