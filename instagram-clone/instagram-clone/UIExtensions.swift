//
//  UIExtensions.swift
//  instagram-clone
//
//  Created by Kent Rogers on 3/28/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

import UIKit


extension UIImage {
    
    func resize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
    }

    var path: URL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Error getting documents Directory")
        }
        
        return documentsDirectory.appendingPathComponent("image")
        
    }
    
}


