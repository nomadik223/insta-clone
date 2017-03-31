//
//  GalleryCell.swift
//  instagram-clone
//
//  Created by Kent Rogers on 3/29/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func stringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    var post : Post! {
        didSet {
            self.imageView.image = post.image
            self.dateLabel.text = self.stringFromDate(date: post.date)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
}
