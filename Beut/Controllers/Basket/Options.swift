//
//  Options.swift
//  Esfenja
//
//  Created by ProjectEgy on 04/08/2022.
//

import UIKit

class OptionsCell: UITableViewCell {
    static let identifier = String(describing: Options.self)


    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var radioButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
