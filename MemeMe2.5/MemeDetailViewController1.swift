//
//  MemeDetailViewController1.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/13/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
//

import Foundation
import UIKit


class MemeDetailViewController1: UIViewController, RedoDelegate {
    
    
    @IBOutlet weak var imageView1: UIImageView!
    
    var meme: Meme?
    var delegate: RedoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnTap = true
        showImage()
        hideBar()
    }
    
    func showImage() {
        guard let image = meme?.memedImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        imageView1.image = image
    }
    
    func hideBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func redo(_ sender: AnyObject) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "MemeEditorVC2") as! MemeEditorVC2
        VC.meme = meme
        VC.delegate = self
        present(VC, animated:  true, completion:  nil)
    }
    
    func backToList(controller: MemeEditorVC2) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
}



