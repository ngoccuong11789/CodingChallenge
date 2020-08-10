//
//  UICollectionView+Ext.swift
//  ListPhotoApp
//
//  Created by Macintosh HD on 8/8/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    // Setup collectionView itemsSize on listPhotosCollectionView
    func setupCollectionViewItemSize(view: UIView,
                                             collectionViewFlowLayout: UICollectionViewFlowLayout,
                                             listPhotosCollectionView: UICollectionView,
                                             defineCell: Int,
                                             deviceType : Model){
        var numberOfItemPerRow: CGFloat = 0
        let lineSpacing: CGFloat = 1
        let interItemSpacing: CGFloat = 1
        if deviceType.rawValue.contains("iPhone") {
            if defineCell == 0 {
                numberOfItemPerRow = 1
            } else {
                numberOfItemPerRow = 2
            }
        } else {
            if defineCell == 0 {
                numberOfItemPerRow = 2
            } else {
                numberOfItemPerRow = 3
                if UIDevice.current.orientation.isLandscape {
                    numberOfItemPerRow = 5
                }
            }
        }
        
        let width = (view.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
        let height = CGFloat(120)
        collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
        listPhotosCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
}
