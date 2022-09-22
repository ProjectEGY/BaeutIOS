//
//  NotificationTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    static let identifier = String(describing: NotificationTableViewCell.self)
   
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    
    func setUpNotificationItem(item:UserNotification){
        time.text = item.time
        itemDescription.text = item.notificationDescription
        title.text = item.title
    }
}
