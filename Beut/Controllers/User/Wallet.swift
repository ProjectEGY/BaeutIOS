//
//  WalletViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import UIKit

@available(iOS 13.0, *)
class WalletViewController: UIViewController {

    @IBOutlet weak var wallet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Wallet".localized

        if let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key:"userAccountInfo"){
            wallet.text = "\(result.wallet!) SAR"
        }
        else{
            wallet.text = "Log in to see your wallet"
        }
    }
    

    @IBAction func chargeWallet(_ sender: Any) {
        showAlertWithTextField()
       
    }
    
    private func showAlertWithTextField(){
        let alretSheet = UIAlertController(title: "ChargeYourWallet".localized, message: nil, preferredStyle: .alert)
        alretSheet.addTextField{
            (textField) in
            textField.placeholder = "EnterChargeValue".localized
            textField.keyboardType = .numberPad
        }
        alretSheet.addAction(UIAlertAction(title: "Charge".localized, style: .default, handler: {
            action in
            
             let chargeValue = alretSheet.textFields![0]
            if let valueOfCharge = chargeValue.text {
                self.chargeWalletUsingAPI(value:valueOfCharge)
            }
            
        }))
     
        alretSheet.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: nil))
        present(alretSheet, animated: true, completion: nil)
    }
    
    private func chargeWalletUsingAPI(value:String){
        print("Value:\(value)")
    }
    

}
