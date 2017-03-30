//
//  GalleryViewController.swift
//  instagram-clone
//
//  Created by Kent Rogers on 3/29/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var allPosts = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 3)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    
    
    func update() {
        CloudKit.shared.getPosts { (posts) in
            if let posts = posts {
                self.allPosts = posts
            }
        }
    }

}


//MARK: UICollectionViewDataSource Extension
extension GalleryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        
        cell.post = self.allPosts[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
    
}

