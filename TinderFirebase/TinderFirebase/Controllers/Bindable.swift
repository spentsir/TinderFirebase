//
//  Bindable.swift
//  TinderFirebase
//
//  Created by Spencer Cawley on 1/1/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
