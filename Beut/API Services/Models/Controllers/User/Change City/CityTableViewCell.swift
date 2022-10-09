//
//  CityTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import UIKit
import Kingfisher
class CityTableViewCell: UITableViewCell {
    static let identifier = String(describing: CityTableViewCell.self)
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    
//    override var isSelected: Bool{
//            didSet{
//                if self.isSelected
//                {
//                    super.isSelected = true
//                    self.checkImage.image = UIImage(named: "selected")!
//                    print("Selected")
//                }
//                else
//                {
//                    super.isSelected = false
//                    self.checkImage.image = UIImage(named: "circle")!
//                    print("Deselected")
//
//                }
//            }
//        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.checkImage.image = UIImage(named: "selected")!
        } else {
            self.checkImage.image = UIImage(named: "circle")!
        }
    }
    
    func setUpCountries(country:Country){
        countryName.text = country.nameEn
        if let image = country.flag{
            let imageFlage = "\(Route.baseUrl)\(image)"
            countryImage.kf.setImage(with:imageFlage.asURL)
        }
    }
    
    func setUpCities(city:Area){
        countryName.text = city.nameEn
    }
}
