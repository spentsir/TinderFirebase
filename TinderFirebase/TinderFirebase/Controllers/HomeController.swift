//
//  ViewController.swift
//  TinderFirebase
//
//  Created by Spencer Cawley on 12/21/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController { 
    
    let topStackView = TopNavigationStackVIew()
    let cardsDeckView = UIView()
    let buttonStackView = HomeBottomControllsStackView()
    
//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
//            User(name: "Jane", age: 20, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"]),
//            Advertiser(title: "TEST FOR ADVERTISING", brandName: "Advertising", posterPhotoName: "space123"),
//            User(name: "Jane", age: 20, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
//        ] as [ProducesCardViewModel]
    
//        let viewModels = producers.map({return $0.toCardViewModel()})
//        return viewModels
//    }()
    
    var cardViewModels = [CardViewModel]() // empty array

    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
        
        setupLayout()
        setupDummyCards()
        fetchUsersFromFirestore()
    }
    
    @objc func handleSettingsButton() {
        print("Show registration page...")
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
    }
    
    // MARK: - Fileprivate
    
    fileprivate func fetchUsersFromFirestore() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("failed to fetch users:", err)
                return
            }
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
                
            })
            self.setupDummyCards()
        }
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
}

