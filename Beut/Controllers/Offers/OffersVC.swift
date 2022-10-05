//
//  OffersVC.swift
//  Beut
//
//  Created by ProjectEgy on 25/09/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class OffersVC: UIViewController {

    @IBOutlet weak var emptyView:UIView!
    @IBOutlet weak var indicator:NVActivityIndicatorView!
    @IBOutlet weak var offersCollectionView:UICollectionView!
    var offers:[ProductModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Offers", comment: "")
        getOffers()
    }
    
    private func getOffers(){
        self.indicator.customIndicator(start: true)
        NetworkService.shared.getOffers(parameters: ["lang":"lang".localized, "page":1] as JSON) { [weak self] result in
            switch result{
            case .success(let data):
                self?.indicator.customIndicator(start: false)
                guard let list = data.data, list.count > 0 else {
                    self?.emptyView.isHidden = false
                    self?.offersCollectionView.isHidden = true
                    return}
                self?.offers = list
                self?.offersCollectionView.reloadData()
                
            case .failure(let error):
                self?.indicator.customIndicator(start: false)
                print(error.localizedDescription)
            }
        }
    }

}
@available(iOS 13.0, *)
extension OffersVC:UICollectionViewDelegate, UICollectionViewDataSource,UIPageViewControllerDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersCollectionViewCell.identifier, for: indexPath) as! OffersCollectionViewCell
        cell.setUpProduct(product: offers[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: self.view.frame.width * 0.45, height: CGFloat(422))
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let productDetails = storyboard.instantiateViewController(withIdentifier: "ProductDetailsVC" ) as! ProductDetailsVC
        productDetails.product = offers[indexPath.row]
        self.navigationController?.pushViewController(productDetails, animated: true)
    }
    
}
