//
//  ImagePickerHelper.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 3/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias ImagePickerHelperCompletion = ((UIImage?) -> Void)!

class ImagePickerHelper: NSObject {
    
    weak var viewController: UIViewController!
    var completion: ImagePickerHelperCompletion
    
    init(viewController: UIViewController, completion: ImagePickerHelperCompletion) {
        self.viewController = viewController
        self.completion = completion
        
        super.init()
        
        self.showPhotoSourceSelection()
    }
    
    func showPhotoSourceSelection() {
        let actionSheet = UIAlertController(title: "Select a photo", message: "Would you like to open library or camera", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            self.showImagePicker(sourceType: .camera)
        }
        
        let libraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePicker(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    func showImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.delegate = self
        
        viewController.present(imagePicker, animated: true, completion: nil)
    }

}

extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        viewController.dismiss(animated: true, completion: nil)
        completion(image)
    }
}
