//
//  ViewController.swift
//  TinderFirebase
//
//  Created by Spencer Cawley on 12/21/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit

class ViewController: UIViewController { 
    
    let topStackView = TopNavigationStackVIew()
    let cardsDeckView = UIView()
    let buttonStackView = HomeBottomControllsStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsDeckView.backgroundColor = .blue
        setupLayout()
        setupDummyCards()
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupDummyCards() {
        print("Setting up dummy cards")
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
}

