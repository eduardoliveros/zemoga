//
//  Extensions.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/9/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func circularLayout() {
        layoutIfNeeded()
        layer.cornerRadius = self.frame.size.width / 2
        clipsToBounds = true
        
        layer.masksToBounds = true
        layer.isOpaque = false
    }
}
