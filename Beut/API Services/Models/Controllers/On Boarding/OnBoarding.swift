//
//  OnBoardingViewControlViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 22/06/2022.
//

import UIKit
struct OnBoardInfo{
    let image:UIImage
    let description:String
    let description2:String
}
class OnBoardingViewController: UIViewController, UIPageViewControllerDelegate {
    
 
    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    let effect = UIInterpolatingMotionEffect(keyPath: "center.x",type: .tiltAlongHorizontalAxis)
    var onBoardingInfo :[OnBoardInfo] = []
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        
        UIView.animate(withDuration: 1.0, animations: {
            self.view.center.x = 650
        })
        
        if #available(iOS 13.0, *) {
            onBoardingInfo = [
                OnBoardInfo(image: UIImage(named: "onboarding1")!, description: "FirsetMessage".localized, description2: "onBoradingDsc1".localized),
                OnBoardInfo(image: UIImage(named: "onboarding2")!, description: "SecondMessage".localized, description2: "onBoradingDsc1".localized),
                OnBoardInfo(image: UIImage(named: "onboarding3")!, description: "ThirdMessage".localized, description2: "onBoradingDsc1".localized)]
        } else {
            onBoardingInfo = [
                OnBoardInfo(image: UIImage(named: "onboarding1")!, description: NSLocalizedString("FirsetMessage", comment: ""), description2: NSLocalizedString("onBoradingDsc1", comment: "")),
                OnBoardInfo(image: UIImage(named: "onboarding2")!, description: NSLocalizedString("SecondMessage", comment: ""), description2: NSLocalizedString("onBoradingDsc1", comment: "")),
                OnBoardInfo(image: UIImage(named: "onboarding3")!, description: NSLocalizedString("ThirdMessage", comment: ""), description2: NSLocalizedString("onBoradingDsc1", comment: ""))]
        }
       
       
        updatePageControlAndLabel()
    }

    
    func updatePageControlAndLabel(){
        pageControl.currentPage = currentPage
        if currentPage < 3 && currentPage >= 0{
//            self.lbl.text = info[currentPage]
           
        }
        
    }
    
    
    @IBAction func scrollRight(_ sender: Any) {
            self.onBoardingCollectionView.scrollToItem(at: IndexPath(item: 0 , section: 0), at: .top, animated: true)
    }
    
    @available(iOS 13.0, *)
    @IBAction func scrollLeft(_ sender: Any) {
        
        if !UserDefaults.standard.didUserSelectCity{
        let storyboard = UIStoryboard(name: "ChangeCity", bundle: nil)
        let selectCity = storyboard.instantiateViewController(withIdentifier: "ChangeCityID") as! ChangeCityViewController
        self.present(selectCity, animated:true, completion:nil)
        }else{
            UserDefaults.standard.hasOnboarded = true
            let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)

            let mainHome = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! MyTabBarViewController
            self.present(mainHome, animated:true, completion:nil)
        }
        
        
    }
    
}


extension OnBoardingViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.setUpOnBoardingInfo(info: self.onBoardingInfo[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.onBoardingCollectionView.frame.width, height: self.onBoardingCollectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        self.updatePageControlAndLabel()
    }
}
