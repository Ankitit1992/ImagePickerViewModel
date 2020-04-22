//
//  ImagePickerViewView.swift
//  UrlSessionDemo
//
//  Created by Ankit Tiwari on 23/04/20.
//  Copyright © 2020 Ankit Tiwari. All rights reserved.
//

import UIKit

/*
 Image Picker View Class
 @Auther : Ankit Tiwari
 
 **/
class ImagePickerViewView: NSObject {
    var imagePickerController = UIImagePickerController()
    var imagePicker : ((_ image:UIImage)-> Void) = {image in}
    
    var controller:UIViewController!
    
    /*
     @parma: controller, use current controller to present the controller, completion handler after finishing task store image for use
     @return : Void
     
     @function : Class Initializer
     **/
    
    @discardableResult
     init(_ controller:UIViewController, _ completionHandeler:@escaping (_ image:UIImage) -> Void) {
        super.init()
        self.controller = controller
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = ["public.image"]
        imagePicker = completionHandeler
        
        alertBox()
    }
    
    /*
     @Param: source use for check source type aviable of not
     @return : Void
     **/
    
    func sourcType(_ sourceType:UIImagePickerController.SourceType) {
           if UIImagePickerController.isSourceTypeAvailable(sourceType) {
               switch sourceType {
                   case .camera:
                       imagePickerController.sourceType = sourceType
                      // imagePickerController.mediaTypes =  UIImagePickerController.availableMediaTypes(for: .camera) ?? []
                       imagePickerController.delegate = self
                      
                   case .photoLibrary:
                       imagePickerController.sourceType = sourceType
                        imagePickerController.delegate = self
                   
                   default:
                       break
               }
               
               controller.present(imagePickerController, animated: true) {
                   
               }
           } else {
               print("Media Type Not avilable")
           }
       }
       
       
    /*
        @func:  use for present alert sheet for user selection
        @return : Void
        **/
       
       func alertBox () {
           let alertController = UIAlertController(title: "", message: "Image Picker View", preferredStyle: .actionSheet)
           let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
               self.sourcType(.camera)
           }
           
           let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
               self.sourcType(.photoLibrary)
           }
           
          
           
           let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
           alertController.addAction(cameraAction)
           alertController.addAction(photoLibraryAction)
          // alertController.addAction(videoAction)
           alertController.addAction(cancel)
           
           controller.present(alertController, animated: true, completion: nil)
       }
}

/*Delegate Method**/
extension ImagePickerViewView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage]
        imagePicker(image as? UIImage ?? UIImage())
        controller.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
