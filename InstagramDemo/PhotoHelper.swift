//
//  PhotoHelper.swift
//  InstagramDemo
//
//  Created by Daniel Ku on 2/25/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = (UIImage?) -> Void

extension PhotoHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        viewController.dismiss(animated: false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}

class PhotoHelper: NSObject {
        // View controller on which AlertViewController and UIImagePickerController are presented
        weak var viewController: UIViewController!
        var callback: PhotoTakingHelperCallback
        var imagePickerController: UIImagePickerController?
        
        init(viewController: UIViewController, callback: @escaping PhotoTakingHelperCallback) {
            self.viewController = viewController
            self.callback = callback
            
            super.init()
            
            showPhotoSourceSelection()
        }
        
        func showPhotoSourceSelection() {
            // Allow user to choose between photo library and camera
            let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .default) { (action) in
                self.showImagePickerController(.photoLibrary)
            }
            
            alertController.addAction(photoLibraryAction)
            
            // Only show camera option if rear camera is available
            if (UIImagePickerController.isCameraDeviceAvailable(.rear)) {
                let cameraAction = UIAlertAction(title: "Photo from Camera", style: .default) { (action) in
                    self.showImagePickerController(.camera)
                }
                
                alertController.addAction(cameraAction)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
        }
        
        func showImagePickerController(_ sourceType: UIImagePickerControllerSourceType) {
            imagePickerController = UIImagePickerController()
            imagePickerController!.sourceType = sourceType
            imagePickerController!.delegate = self
            
            self.viewController.present(imagePickerController!, animated: true, completion: nil)
        }
}


