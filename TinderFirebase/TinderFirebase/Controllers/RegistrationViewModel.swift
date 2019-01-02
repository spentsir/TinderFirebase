//
//  RegistrationViewModel.swift
//  TinderFirebase
//
//  Created by Spencer Cawley on 1/1/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? { didSet {checkFormValidity()} }
    var email: String? { didSet {checkFormValidity()} }
    var password: String? { didSet {checkFormValidity()} }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    // Reactive programming
    var bindableIsFormValid = Bindable<Bool>()
}
