//
//  CompactCollectionViewCell.swift
//  ListPhotoApp
//
//  Created by Macintosh HD on 8/8/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import UIKit

class CompactCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var size: UILabel!
    var listPhotosModel: ListPhotosModel?{
        didSet{
            displayCompactCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Display Cell for Compact List Photo
       func displayCompactCell() {
           if let authorData = listPhotosModel?.author, let sizeWidth = listPhotosModel?.width, let sizeHeight = listPhotosModel?.height {
               author.text = "\(authorData)"
               size.text = "size : \(sizeWidth)x\(sizeHeight) "
               photo.downloadImages(imageURL: listPhotosModel?.download_url ?? "")
           }
       }
    
}
