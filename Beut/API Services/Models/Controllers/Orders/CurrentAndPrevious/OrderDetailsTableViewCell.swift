//
//  OrderDetailsTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 25/07/2022.
//

import UIKit
import Kingfisher
class OrderDetailsTableViewCell: UITableViewCell {

    static let identifier = String(describing: OrderDetailsTableViewCell.self)
   
    @IBOutlet weak var showDetailsI: UIImageView!
    
    @IBOutlet weak var showDetailsL: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderAddress: UILabel!
    @IBOutlet weak var orderCancel: UILabel!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            self.setUpLanguage()
        }
    }
    func setUpOrderDetails(order:Orders){
        self.orderImage.makeImageCircular(anyImage: orderImage.image!)
        orderNumber.text = order.orderCode
        orderDate.text = order.orderDate
        orderName.text = order.storeName
        orderAddress.text = order.address
        orderCancel.text = order.orderStatus
        if let image = order.storeImageURL{
            let imageUrl = "\(Route.baseUrl)\(image)"
            orderImage.kf.setImage(with:imageUrl.asURL)
        }
    }
    private func setUpLanguage(){
        let currentLanguage = Locale.current.languageCode
        if currentLanguage == "ar"{
            showDetailsI.image = UIImage(named: "arabic_arrow")
        }
    }
}
