//
//  ListPhotosViewController+Ext.swift
//  ListPhotoApp
//
//  Created by Macintosh HD on 8/8/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import Foundation
import UIKit

extension ListPhotosViewController: UICollectionViewDelegate {
    
}

extension ListPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhotosVM.listPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Display loading Cell
        if indexPath.row == listPhotosVM.listPhotos.count - 1 {
            let cell = listPhotosCollectionView.dequeueReusableCell(withReuseIdentifier: "loading", for: indexPath)
            return cell
        } else {
            if idSelected == 0 {
                let cell = listPhotosCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.RegularListPhotosCellIdentifier, for: indexPath) as! RegularListPhotoCollectionViewCell
                cell.listPhotosModel = listPhotosVM.listPhotos[indexPath.row]
                return cell
            } else {
                let cell = listPhotosCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.CompactListPhotosCellIdentifier, for: indexPath) as! CompactCollectionViewCell
                cell.listPhotosModel = listPhotosVM.listPhotos[indexPath.row]
                return cell
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if  indexPath.row == listPhotosVM.listPhotos.count - 1 {
            listPhotosVM.limitForPerPage += 10
            listPhotosVM.fetchListPhotos(refreshController: myRefreshControl, refresh: false)
        }

        
    }
    
    
}
