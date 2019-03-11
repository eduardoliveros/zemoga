//
//  ViewControllerFactory.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import Foundation

struct ViewControllerFactory {
    
    static func instantiatePostViewController() -> PostViewController {
        return Storyboards.home.instantiateViewController(withIdentifier: ViewIdentifier.postViewController) as! PostViewController
    }
    
    static func instantiateDetailViewController() -> DetailViewController {
        return Storyboards.home.instantiateViewController(withIdentifier: ViewIdentifier.detailViewController) as! DetailViewController
    }
}
