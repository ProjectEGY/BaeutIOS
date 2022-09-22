//
//  Sliderlayout.swift
//  Esfenja
//
//  Created by ProjectEgy on 18/07/2022.
//

import UIKit

class Sliderlayout: UICollectionViewLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
