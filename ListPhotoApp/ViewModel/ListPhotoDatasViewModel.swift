
//
//  ListPhotoDatas.swift
//  ListPhotoApp
//
//  Created by Macintosh HD on 8/8/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
class ListPhotoDataViewModel {
    weak var vc: ListPhotosViewController?
    var listPhotos = [ListPhotosModel]()
    var limitForPerPage = 10
    //Fetch Data from API
    func fetchListPhotos(refreshController : UIRefreshControl,
                         refresh: Bool){
        if refresh {
            refreshController.beginRefreshing()
        }
        AF.request("https://picsum.photos/v2/list?page=1&limit=\(self.limitForPerPage)").response { response in
        if let data = response.data {
            do{
                let listPhotoResponse = try JSONDecoder().decode([ListPhotosModel].self, from: data)
                DispatchQueue.main.async{
                    if refresh {
                        refreshController.endRefreshing()
                    }
                    self.listPhotos.removeAll()
                    self.listPhotos.append(contentsOf: listPhotoResponse)
                    self.vc?.listPhotosCollectionView.reloadData()
            }
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    }
}
