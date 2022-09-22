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
}
class OnBoardingViewController: UIViewController, UIPageViewControllerDelegate {
    
    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lbl: UILabel!
    
    var onBoardingInfo :[OnBoardInfo] = []
    var currentPage = 0
    let effect = UIInterpolatingMotionEffect(keyPath: "center.x",type: .tiltAlongHorizontalAxis)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        UIView.animate(withDuration: 1.0, animations: {
            self.view.center.x = 650
        })
        
        if #available(iOS 13.0, *) {
            onBoardingInfo = [
                OnBoardInfo(image: UIImage(named: "ESFENJA")!, description: "FirsetMessage".localized),
                OnBoardInfo(image: UIImage(named: "ESFENJA")!, description: "SecondMessage".localized),
                OnBoardInfo(image: UIImage(named: "ESFENJA")!, description: "ThirdMessage".localized)]
        } else {
            // Fallback on earlier versions
        }
       
    }
    
    @IBAction func signUp(_ sender: Any) {
        UserDefaults.standard.hasOnboarded = true
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signUpViewcontroller = storyboard.instantiateViewController(withIdentifier: "SignUpID")
        present(signUpViewcontroller, animated: true, completion: nil)
    }
    
    @IBAction func signIn(_ sender: Any) {
        UserDefaults.standard.hasOnboarded = true
    }
 
}
extension OnBoardingViewController:UICollectionViewDelegate, UICollectionViewDataSource{
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
        self.pageControl.currentPage = self.currentPage
    }
    
}
