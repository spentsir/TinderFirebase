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
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
            User(name: "Jane", age: 20, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"]),
            Advertiser(title: "TEST FOR ADVERTISING", brandName: "Advertising", posterPhotoName: "space123"),
            User(name: "Jane", age: 20, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels 
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.cardViewModel = cardVM
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

