//
//  ChangeCityViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ChangeCityViewController:UIViewController{
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var countryDropDownIcon: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var cityDropDownIcon: UIButton!
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var citiesHight: NSLayoutConstraint!
    @IBOutlet weak var countriesHight: NSLayoutConstraint!
    
    var isCountriesShown = false
    var isCitiesShown = false
    var didUserSelectCity = false
    var areaIdSelectedByUser = -1
    var areaNameSelectedByUser = ""
    var countries:[Country] = []
    var areas:[Area] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ChangeCity".localized
        
        loadCountries()
        countriesTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        citiesTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    @IBAction func showCountries(_ sender: Any) {
        
        countriesTableView.isHidden = isCountriesShown
        if isCountriesShown{
            countryDropDownIcon.setImage(UIImage(named: "down_arrow"), for: .normal)
        }else{
            countryDropDownIcon.setImage(UIImage(named: "up_arrow"), for: .normal)        }
        isCountriesShown = !isCountriesShown
            
        }
    
    @IBAction func showCities(_ sender: Any) {
        isCitiesShown = !isCitiesShown
        citiesTableView.isHidden = isCitiesShown
        if isCitiesShown{
            cityDropDownIcon.setImage(UIImage(named: "down_arrow"), for: .normal)
        }else{
            cityDropDownIcon.setImage(UIImage(named: "up_arrow"), for: .normal)        }        }
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.didUserSelectCity = true
        UserDefaults.standard.areaId = areaIdSelectedByUser
        let storyBoard : UIStoryboard = UIStoryboard(name: "TabBarNavigator", bundle:nil)
        
        let mainHome = storyBoard.instantiateViewController(withIdentifier: "MainTabID") as! MyTabBarViewController
        
        self.present(mainHome, animated:true, completion:nil)
    }
    
    
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension ChangeCityViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == countriesTableView{
            return countries.count
        }
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for:indexPath) as! CityTableViewCell
        if tableView == countriesTableView{
            cell.setUpCountries(country: countries[indexPath.row])
        }
        else{
            cell.setUpCities(city: areas[indexPath.row])
        }
        
        return cell
    }
    
    private func loadCountries(){
        scroll.isHidden = true
        indicator.customIndicator(start: true)
        NetworkService.shared.selectCountryAndCity(parameters: nil){
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                if let countries = data.data{
                    self?.countries = countries
                    self?.countriesHight.constant = CGFloat(Double(98 * countries.count))
                    self?.countriesTableView.reloadData()
                    self?.scroll.isHidden = false
                    self?.indicator.customIndicator(start: false)
                }
            case .failure(let error):
                self?.scroll.isHidden = false
                self?.indicator.customIndicator(start: false)
                
                print(error.localizedDescription)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == countriesTableView{
            areas = countries[indexPath.row].areas!
            areas.insert(Area(id: 0, countryID: 0, nameAr: "All".localized, nameEn: "All"), at: 0)
            citiesHight.constant = CGFloat(Double(98 * areas.count))
            citiesTableView.reloadData()
        }
        else if tableView == citiesTableView{
            didUserSelectCity = true
            areaIdSelectedByUser = areas[indexPath.row].id!
            UserDefaults.standard.currentSelectedArea = areas[indexPath.row].nameEn!
            nextButton.isEnabled = true
        }
    }
    
}


