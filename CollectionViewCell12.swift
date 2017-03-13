//
//  CollectionViewCell.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/13/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell12: UICollectionViewCell {
    
    @IBOutlet weak var imageView2: UIImageView!
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                imageView2?.image = meme.memedImage ?? meme.image
            }
        }
    }
}
