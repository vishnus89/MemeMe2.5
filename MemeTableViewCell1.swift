//
//  MemeTableViewCell1.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/13/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewCell1: UITableViewCell {
    @IBOutlet weak var memedImage1: UIImageView!
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                memedImage1.image = meme.memedImage ?? meme.image
                
            }
        }
    }
}

