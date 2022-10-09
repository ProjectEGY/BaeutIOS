//
//  OrdersViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 26/06/2022.
//

import UIKit
import NVActivityIndicatorView

@available(iOS 13.0, *)
class OrdersViewController: UIViewController {

    @IBOutlet weak var emptyOrders: UIView!
    @IBOutlet weak var orderDetailsTable:UITableView!
    @IBOutlet weak var ordersIdicator: NVActivityIndicatorView!
    @IBOutlet weak var segment: UISegmentedControl!
    var userOrders:[Orders] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders".localized
        emptyOrSomeErrorOccured(yeah:true)
        loadCurrentOrders()
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        orderDetailsTable.register(UINib(nibName: OrderDetailsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderDetailsTableViewCell.identifier)
    }
    


    @IBAction func selectedSegment(_ sender: Any) {
       
        switch segment.selectedSegmentIndex{
            case 0:
                self.loadCurrentOrders()
            case 1:
                self.loadPreviousOrders()
            default:
                break
            }
    }
    private func loadPreviousOrders(){
        if UserDefaults.standard.isUserLoggedInt{
            self.emptyOrders.isHidden = true
            self.orderDetailsTable.isHidden = true
        self.ordersIdicator.customIndicator(start: true)
            let params = ["lang":"lang".localized]
        NetworkService.shared.getPreviousOrders(parameters: params){
            [weak self] (result) in
            
            switch result{
            case .success(let order):
                self?.ordersIdicator.customIndicator(start: false)
                if let orders = order.data{
                    if orders.count == 0{
                        self?.emptyOrders.isHidden = false
                        self?.orderDetailsTable.isHidden = true
                    }else{
                        
                        self?.ordersIdicator.customIndicator(start: false)
                        self?.userOrders = orders
                        self?.orderDetailsTable.reloadData()
                        self?.orderDetailsTable.isHidden = false
                    }
                }
            case .failure(let error):
                self?.ordersIdicator.customIndicator(start: false)
                self?.showInofToUser(title: "Error".localized, message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
        }else{
            self.emptyOrders.isHidden = false
            self.orderDetailsTable.isHidden = true
        }
    }
    
    private func loadCurrentOrders(){
        if UserDefaults.standard.isUserLoggedInt{
            self.emptyOrders.isHidden = true
            self.orderDetailsTable.isHidden = true
        self.ordersIdicator.customIndicator(start: true)
            let params = ["lang":"lang".localized]
        NetworkService.shared.getCurrentOrders(parameters: params){
            [weak self] (result) in
            
            switch result{
            case .success(let order):
                self?.ordersIdicator.customIndicator(start: false)
                if let orders = order.data{
                    if orders.count == 0{
                        self?.emptyOrders.isHidden = false
                        self?.orderDetailsTable.isHidden = true
                    }else{
                    self?.ordersIdicator.customIndicator(start: false)
                    self?.userOrders = orders
                    self?.orderDetailsTable.reloadData()
                    self?.orderDetailsTable.isHidden = false
                    }
                }
            case .failure(let error):
                self?.ordersIdicator.customIndicator(start: false)
                self?.showInofToUser(title: "Error".localized, message: error.localizedDescription)
            }
           }
        }
        else{
            self.emptyOrders.isHidden = false
            self.orderDetailsTable.isHidden = true
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func emptyOrSomeErrorOccured(yeah:Bool){
        emptyOrders.isHidden = yeah
        orderDetailsTable.isHidden = yeah
    }
    
}

@available(iOS 13.0, *)
extension OrdersViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailsTableViewCell.identifier) as! OrderDetailsTableViewCell
        cell.setUpOrderDetails(order: userOrders[indexPath.row])
        
        self.orderDetailsTable.beginUpdates()
        self.orderDetailsTable.endUpdates()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OrderDetailsViewController.orderId = userOrders[indexPath.row].orderID
        let storyBoard : UIStoryboard = UIStoryboard(name: "OrdersDetails", bundle:nil)
        
        let orderDetils = storyBoard.instantiateViewController(withIdentifier: "OrderDetailsID") as! OrderDetailsViewController
        
        self.navigationController?.pushViewController(orderDetils, animated: true)
//        self.present(orderDetils, animated:true, completion:nil)
        
        
    }
    
}
