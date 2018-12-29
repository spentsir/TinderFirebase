//
//  ViewController.swift
//  TinderFirebase
//
//  Created by Spencer Cawley on 12/21/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit

class HomeController: UIViewController { 
    
    let topStackView = TopNavigationStackVIew()
    let cardsDeckView = UIView()
    let buttonStackView = HomeBottomControllsStackView()
    
//    let users = [
//    User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
//    User(name: "Jane", age: 20, profession: "Teacher", imageName: "lady4c")
//    ]
    
    let cardViewModels = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c").toCardViewModel(),
        User(name: "Jane", age: 20, profession: "Teacher", imageName: "lady4c").toCardViewModel()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.imageView.image = UIImage(named: cardVM.imageName)
            cardView.informationLabel.attributedText = cardVM.attributedString
            cardView.informationLabel.textAlignment = cardVM.textAlignment
            
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
}

