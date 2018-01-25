//
//  Meme.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/12/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
// the Meme model is a struct that includes:
//
//two strings representing the top and bottom text
//the original image
//a memed image combining image and text


import Foundation
import UIKit

struct Meme {
    var topText:String?
    var bottomText:String?
    var image: UIImage?
    var memedImage: UIImage?
    
    init(topText: String?, bottomText: String?, image: UIImage?, memedImage: UIImage?) {
    
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
    
    init(from meme: Meme?){
        self.init(topText: meme?.topText, bottomText: meme?.bottomText, image: meme?.image, memedImage: meme?.memedImage)
    }
    
}
