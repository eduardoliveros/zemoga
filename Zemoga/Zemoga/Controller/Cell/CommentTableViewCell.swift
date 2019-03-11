//
//  CommentTableViewCell.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "CommentCell", bundle: nil)
    }
}
