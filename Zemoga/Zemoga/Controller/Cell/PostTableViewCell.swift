//
//  PostTableViewCell.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var unReadIndicator: UIView!
    @IBOutlet weak var starView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        unReadIndicator.circularLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class func nib() -> UINib {
        return UINib(nibName: "PostCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        unReadIndicator.isHidden = false
        starView.isHidden = true
    }
}
