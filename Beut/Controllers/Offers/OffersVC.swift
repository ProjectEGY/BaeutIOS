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

    @IBOutlet weak var indicator:NVActivityIndicatorView!
    @IBOutlet weak var offersCollectionView:UICollectionView!
    var offers:[ProductModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getOffers()
    }
    
    private func getOffers(){
        self.indicator.customIndicator(start: true)
        NetworkService.shared.getOffers(parameters: ["lang":"lang".localized, "page":1] as JSON) { [weak self] result in
            switch result{
            case .success(let data):
                self?.indicator.customIndicator(start: false)
                guard let list = data.data else {return}
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
        
        cell.plausBtn.tag = indexPath.row
        cell.minusBtn.tag = indexPath.row
        cell.addToBasketBtn.tag = indexPath.row
        cell.plausBtn.addTarget(self, action: #selector(incrementQuantity(sender:)), for: .touchUpInside)
        cell.minusBtn.addTarget(self, action: #selector(decrementQuantity(sender:)), for: .touchUpInside)
        cell.addToBasketBtn.addTarget(self, action: #selector(addToBasket(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: self.view.frame.width * 0.45, height: CGFloat(303))
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
 
    
    @objc func decrementQuantity(sender:UIButton){
        let cell = self.offersCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! OffersCollectionViewCell
        if cell.quantityValue > 1{
            cell.quantityValue -= 1
        }
        
        cell.quantity.text = "\(cell.quantityValue)"
    }
    
    @objc func incrementQuantity(sender:UIButton){
        let cell = self.offersCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! OffersCollectionViewCell
        
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
            guard let productId = offers[sender.tag].productId else {return}
            let cell = self.offersCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! OffersCollectionViewCell
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
        self.indicator.customIndicator(start: true, type: .ballTrianglePath)
           
          
            
            NetworkService.shared.addToBasket(body: body){
                [weak self] (result) in
                
                switch result{
                case .success(let data):
                    if data.errorCode == 0{
                        self?.indicator.customIndicator(start: false)
                        self?.showInofToUser(message: "productadd".localized)
                       
                    }else{
                        self?.indicator.customIndicator(start: false)
                        if let message = data.errorMessage{
                            self?.showInofToUser(title: "Error", message: "\(message)")
                        }
                       
                      
                    }
                    case .failure(let error):
                    self?.indicator.customIndicator(start: false)
                    self?.showInofToUser(title: "Error", message: "\(error.localizedDescription)")
                }
            }
    }
    
    
}
