//
//  AccountTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 25/06/2022.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsName: UILabel!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var backIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpSettingsAttributes(sttName:String, sttIcon:UIImage, backIcon:UIImage)
    {
        self.settingsName.text = sttName
        
        self.settingsIcon.image = sttIcon
        
        self.backIcon.image = backIcon
    }

}
