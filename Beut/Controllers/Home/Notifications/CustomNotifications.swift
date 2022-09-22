//
//  CustomNotifications.swift
//  Esfenja
//
//  Created by ProjectEgy on 24/06/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class CustomNotifications: UIViewController {

    @IBOutlet weak var noNotifications: UILabel!
    var notifications:[UserNotification] = []
    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var notificationsIndicator: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications".localized
        notificationsTableView.register(UINib(nibName: NotificationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NotificationTableViewCell.identifier)
        self.loadNotifications()
    }
    private func loadNotifications(){
        notificationsTableView.isHidden = true
        if UserDefaults.standard.isUserLoggedInt{
        notificationsTableView.isHidden = true
        notificationsIndicator.customIndicator(start: true)
        let params = ["IsWorker":false] as [String:Any]
        NetworkService.shared.getNotifications(parameters: params){
            [weak self] (result) in
            
            switch result{
            case .success(let data):
               
                if let data = data.data{
                    if data.count != 0{
                        self?.notifications = data
                        self?.notificationsTableView.reloadData()
                        self?.notificationsTableView.isHidden = false
                        self?.notificationsIndicator.customIndicator(start: false)
                    }
                }else{
                    self?.noNotifications.isHidden = false
                    self?.notificationsIndicator.customIndicator(start: false)
                }
            case .failure(let error):
                self?.notificationsIndicator.customIndicator(start: false)
                self?.noNotifications.text = error.localizedDescription
               
            }
        }
        }
    }
  
}


@available(iOS 13.0, *)
extension CustomNotifications:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier) as! NotificationTableViewCell
        
        cell.setUpNotificationItem(item: notifications[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if notifications[indexPath.row].type == 3{
            OrderDetailsViewController.orderId = notifications[indexPath.row].requestID

            let storyBoard : UIStoryboard = UIStoryboard(name: "OrdersDetails", bundle:nil)
            
            let orderDetils = storyBoard.instantiateViewController(withIdentifier: "OrderDetailsID") as! OrderDetailsViewController
            self.navigationController?.pushViewController(orderDetils, animated: true)
        }
    }
    
    
}
