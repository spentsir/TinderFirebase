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

class CardViewModel {
    // define the properties that our view will display/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image =  UIImage(named: imageName)
            imageIndexObserver?(imageIndex, image)
        }
    }
    
    // Reactive Programming Logic
    var imageIndexObserver: ((Int, UIImage?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}

// what exactly do we do with this card view model thing?? (head back into controller)

