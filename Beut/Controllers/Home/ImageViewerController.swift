//
//  ImageViewerController.swift
//  Esfenja
//
//  Created by ProjectEgy on 02/08/2022.
//

import UIKit
import ImageSlideshow
import Kingfisher
class ImageViewerController: UIViewController {
    
    var placeholder = UIImage(named: "avatar")
    

    
    static var sliderImages:[SingleSlide]?
    @IBOutlet weak var slider: ImageSlideshow!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageViewer: UICollectionView!
    var gestureRecognizer = UIGestureRecognizer()
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slider.addGestureRecognizer(gestureRecognizer)
        slider.setImageInputs([
            KingfisherSource(url: URL(string: "https://picsum.photos/id/237/200/300")!, placeholder: nil, options: nil),
            KingfisherSource(url: URL(string: "https://picsum.photos/id/238/200/300")!, placeholder: nil, options: nil)
        ]

        )
        slider.slideshowInterval = 4
        slider.zoomEnabled = true
        slider.pageIndicator!.view.tintColor = .red
    }
    
   

    @objc func didTap() {
      slider.presentFullScreenController(from: self)
    }
  

}
