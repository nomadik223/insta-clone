//
//  HomeViewController.swift
//  instagram-clone
//
//  Created by Kent Rogers on 3/27/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

import UIKit
import CloudKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            filterButtonTopConstraint.constant = 8
        
            UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //postButtonBottomConstraint.constant = 8
        filterButtonTopConstraint.constant = 8
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType){
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Info: \(info)")
        
        guard let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage else { return }
        
        Filters.originalImage = originalImage
        
        self.imageView.image = info["UIImagePickerControllerEditedImage"] as? UIImage
        
        imagePickerControllerDidCancel(picker)
    }
    
    func doesHaveCamera() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }
    
    @IBAction func imageTap(_ sender: Any) {
        print("User Tapped Image!")
        self.presentActionSheet()
    }
    
    
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        if let image = self.imageView.image {
            let newPost = Post(image: image)
            CloudKit.shared.save(post: newPost, completion: { (success) in
                
                if success {
                    print("Saved Post successfully to CloudKit")
                } else {
                    print("We did NOT successfully save to CloudKit")
                }
            })
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        }
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        
        guard let image = self.imageView.image else { return }
        
        let alertController = UIAlertController(title: "Filter", message: "Please select a filter.", preferredStyle: .alert)
        
        let blackAndWhiteAction = UIAlertAction(title: "Black & White", style: .default) { (action) in
            Filters.filter(name: .blackAndWhite, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
            Filters.filter(name: .vintage, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let comicEffectAction = UIAlertAction(title: "Comic Effect", style: .default) { (action) in
            Filters.filter(name: .comicEffect, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let bumpDistortionAction = UIAlertAction(title: "Bump Distortion", style: .default) { (action) in
            Filters.filter(name: .distorted, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let lineOverlayAction = UIAlertAction(title: "Line Overlay", style: .default) { (action) in
            Filters.filter(name: .lineOverlay, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let resetAction = UIAlertAction(title: "Reset Image", style: .destructive) { (action) in
            self.imageView.image = Filters.originalImage
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(blackAndWhiteAction)
        alertController.addAction(vintageAction)
        alertController.addAction(comicEffectAction)
        alertController.addAction(bumpDistortionAction)
        alertController.addAction(lineOverlayAction)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentActionSheet(){
        
        let actionSheetController = UIAlertController(title: "Source", message: "Please select Source Type", preferredStyle: .actionSheet)
        
        actionSheetController.popoverPresentationController?.sourceView = self.view
        actionSheetController.modalPresentationStyle = .popover
        
        if doesHaveCamera() == true {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.presentImagePickerWith(sourceType: .camera)
            }
            actionSheetController.addAction(cameraAction)
        }
        
        let photoAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        
        actionSheetController.addAction(photoAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
}
