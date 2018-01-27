//
//  DetailViewController.swift
//  Reddit Top
//
//  Created by jorge jesus mendoza balleza on 1/26/18.
//  Copyright © 2018 jorge jesus mendoza balleza. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var entryImage: UIImageView!
    var imageURL : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageURL = imageURL{
            let service = RedditService()
            service.downloadImage(imageURL, completion: { (image, error) in
                self.activityIndicator.stopAnimating()
                if let image = image{
                    self.entryImage.image = image
                } else {
                    self.entryImage.image = #imageLiteral(resourceName: "NoImage")
                }
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
