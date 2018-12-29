//
//  CardViewModel.swift
//  TinderFirebase
//
//  Created by Spencer Cawley on 12/28/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel 
}

struct CardViewModel {
    // define the properties that our view will display/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}

// what exactly do we do with this card view model thing?? (head back into controller)

