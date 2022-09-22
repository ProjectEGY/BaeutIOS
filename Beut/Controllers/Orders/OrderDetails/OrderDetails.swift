//
//  OrderDetailsViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 25/07/2022.
//

import UIKit
import Kingfisher
import MapKit
import CoreLocation
import NVActivityIndicatorView
@available(iOS 13.0, *)
class OrderDetailsViewController: UIViewController {
    
    
    static var orderId:Int?
    var orderItems:[BasketItem] = []
    var userAddress:UserAddress?
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var orderCode: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var orderDeliveryFees: UILabel!
    @IBOutlet weak var orderSubTotal: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderAddress: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var itemsTableViewHight: NSLayoutConstraint!
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "OrderDetails".localized
        itemsTableView.register(UINib(nibName: ItemDetailsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
        
        if let orderId = OrderDetailsViewController.orderId{
            getOrderDetails(orderId:orderId)
        }
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
        
    @IBAction func openLocation(_ sender: Any) {
        print("Clicked")
        if let result = userAddress{
            let coordinates = CLLocationCoordinate2DMake(result.longitude!, result.latitude!)
            openMapsAppWithDirections(to: coordinates, destinationName: result.name!)
        }
    }
     
    func getOrderDetails(orderId:Int){
        indicator.customIndicator(start: true)
        let params = ["OrderId":orderId, "lang":"lang".localized] as [String:Any]
        NetworkService.shared.getOrderDetails(parameters: params){
            [weak self] (result) in
            
            switch result{
                
            case .success(let details):
                if let details = details.data{
                    self?.userAddress = details.userAddress!
                    if let items = details.items{
                        self?.orderItems = items
                        self?.setUpOrderDetails(order:details)
                        self?.itemsTableViewHight.constant = CGFloat(Double(130 * items.count))
                        self?.itemsTableView.reloadData()
                        self?.indicator.customIndicator(start: false)
                        self?.scrollView.isHidden = false
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
        print("Clicked2")
      let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = name // Provide the name of the destination in the To: field
        mapItem.openInMaps(launchOptions: options)
    }
    func setUpOrderDetails(order:OrderDetails){
       

        orderCode.text! += order.code!
        orderTotal.text = "\(order.total!)"
        orderDeliveryFees.text = "\(order.deliveryFees!)"
        orderSubTotal.text = "\(order.subTotal!)"
      
        orderStatus.text = order.orderStatus!
        orderAddress.text = order.userAddress?.address
        orderDate.text = order.createDate

    }
}

@available(iOS 13.0, *)
extension OrderDetailsViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsTableViewCell.identifier) as! ItemDetailsTableViewCell
        cell.setUpItemDetails(item: orderItems[indexPath.row])
        return cell
    }
    
    
}
