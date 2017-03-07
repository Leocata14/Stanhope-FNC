//
//  EditProfileTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 3/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import AlamofireImage


class EditProfileTableVC: UITableViewController {
    
    let imageCache = AutoPurgingImageCache()
    
    var shimmeringView: FBShimmeringView!
    

   
    var profileImage: UIImage!
    var profileChanged = false
    var user: FIRUser!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    
    var imagePickerHelper: ImagePickerHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shimmeringView = FBShimmeringView(frame: profileImageView.frame)
        self.shimmeringView.contentView = profileImageView
        self.view.addSubview(shimmeringView)
        
        
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
        profileImageView.clipsToBounds = true
        
        if let currentUser = FIRAuth.auth()?.currentUser {
            self.user = currentUser
            print(user.email)
            let email = user.email
            let uid = user.uid
            let photoURL = user.photoURL
            
            emailTextField.text = email
            
            if let cachedProfileImage = imageCache.image(withIdentifier: "profileImage") {
                self.profileImageView.image = cachedProfileImage
            } else {
                self.shimmeringView.isShimmering = true
                DataService.ds.REF_STORAGE_PROFILEIMAGES.child(user.uid).data(withMaxSize: 1 * 1024 * 1024, completion: { (imgData, error) in
                    if error == nil && imgData != nil {
                        let image = UIImage(data: imgData!)
                        self.profileImageView.image = image
                        self.imageCache.add(image!, withIdentifier: "profileImage")
                        self.shimmeringView.isShimmering = false
                    } else {
                        print(error)
                    }
                })
            }
        }

    }


    
    @IBAction func changeProfileImageButtonTapped(_ sender: Any) {
        imagePickerHelper = ImagePickerHelper(viewController: self, completion: { (image) in
            self.profileImageView.image = image
            self.profileImage = image
            self.profileChanged = true
        })
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        if self.emailTextField.text != user.email {
            profileChanged = true
            print("email has changed")
            
            FIRAuth.auth()?.currentUser?.updateEmail(emailTextField.text!, completion: { (error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    // NO ERROR
                    print("Email Changed!")
                }
            })
        }
        
        if profileImageView.image != #imageLiteral(resourceName: "user") {
            print("image has changed")
            let image = profileImageView.image
            let ref = self.user.uid
            let imageRef = DataService.ds.REF_STORAGE_PROFILEIMAGES.child(ref)
            
            let resizedImage = image?.resized()
            
            let imageData = UIImageJPEGRepresentation(resizedImage!, 0.9)
            
            imageRef.put(imageData!, metadata: nil)
            let downloadLink = imageRef.description
            
            DataService.ds.REF_USERS.child(user.uid).updateChildValues(["profileImageURL":downloadLink])
            
        }
        
        
        
        
    }

}

private extension UIImage {
    func resized() -> UIImage {
        let height: CGFloat = 800.0
        let ratio = self.size.width / self.size.height
        let width = height * ratio
        
        let newSize = CGSize(width: width, height: height)
        let newRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: newRect)
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
