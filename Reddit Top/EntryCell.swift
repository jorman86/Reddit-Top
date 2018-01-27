//
//  EntryCell.swift
//  Reddit Top
//
//  Created by jorge jesus mendoza balleza on 1/26/18.
//  Copyright © 2018 jorge jesus mendoza balleza. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell, EntryDelegate {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func imageReady(image: UIImage?) {
        activityIndicator.stopAnimating()
        if let image = image{
            thumbnailImage.image = image
        } else {
            thumbnailImage.image = #imageLiteral(resourceName: "NoImage")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
