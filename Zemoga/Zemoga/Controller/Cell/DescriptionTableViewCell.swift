//
//  DescriptionTableViewCell.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "DescriptionCell", bundle: nil)
    }
}
