//
//  GalleryTableViewCell.swift
//  EZLapse
//
//  Created by Jeffrey Chen on 11/14/15.
//  Copyright © 2015 Jeffrey Chen. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

  @IBOutlet weak var galleryImage: UIImageView!
  @IBOutlet weak var galleryLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
