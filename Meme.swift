//
//  Meme.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/12/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText:String?
    let bottomText:String?
    let image: UIImage?
    let memedImage: UIImage?
    
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
