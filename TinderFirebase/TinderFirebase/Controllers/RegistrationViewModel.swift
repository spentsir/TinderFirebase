//
//  RegistrationViewModel.swift
//  TinderFirebase
//
//  Created by Spencer Cawley on 1/1/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? { didSet {checkFormValidity()} }
    var email: String? { didSet {checkFormValidity()} }
    var password: String? { didSet {checkFormValidity()} }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err {
                completion(err)
                return
            }
            print("Successfully registered user:", res?.user.uid ?? "")
            
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        // Can only upload images to Firebase storage once you are autorized
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil, completion: { (_, err) in
            
            if let err = err {
                completion(err)
                return // bail
            }
            print("finished uploading image to storage")
            ref.downloadURL(completion: { (url, err) in
                if let err = err {
                    completion(err)
                    return
                }
                
                self.bindableIsRegistering.value = false
                print("download url of our image is:", url?.absoluteURL ?? "")
                // sore the download url into Firestore
                
                let imageURL = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageURL: imageURL, completion: completion)
                completion(nil)
            })
        })
    }
    
    fileprivate func saveInfoToFirestore(imageURL: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageURL1": imageURL]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err {
                completion(err)
                return
            }
            print("Saved info to firestore")
            completion(nil)
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
}
