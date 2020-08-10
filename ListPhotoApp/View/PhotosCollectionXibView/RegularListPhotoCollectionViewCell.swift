//
//  ListPhotoCollectionViewCell.swift
//  ListPhotoApp
//
//  Created by Macintosh HD on 8/8/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import UIKit

class RegularListPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var author: UILabel!
    var listPhotosModel: ListPhotosModel?{
        didSet{
            displayRegularCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Display Cell for Regular List Photo
    func displayRegularCell() {
        if let authorData = listPhotosModel?.author,
            let sizeWidth = listPhotosModel?.width,
            let sizeHeight = listPhotosModel?.height {
            author.text = "\(authorData)"
            size.text = "size:\(sizeWidth)x\(sizeHeight) "
            photo.downloadImages(imageURL: listPhotosModel?.download_url ?? "")
        }
        
    }
}
