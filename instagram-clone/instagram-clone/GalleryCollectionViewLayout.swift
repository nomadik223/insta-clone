//
//  GalleryCollectionViewLayout.swift
//  instagram-clone
//
//  Created by Kent Rogers on 3/29/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

import UIKit

class GalleryCollectionViewLayout: UICollectionViewFlowLayout {
    
    var columns = 2
    let spacing: CGFloat = 1.0
    
    var screenWidth : CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var itemWidth : CGFloat {
        let availableWidth = screenWidth - (CGFloat(self.columns) * self.spacing)
        return availableWidth / CGFloat(self.columns)
    }
    
    init(columns: Int = 2) {
        self.columns = columns
        
        super.init()
        
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
        
        
    }

}
