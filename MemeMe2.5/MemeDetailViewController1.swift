//
//  MemeDetailViewController1.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/13/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
/* Add an Edit button(Redo) as seperate VC to the Meme Detail View that launches the Meme Editor to allow the user to edit an already existing meme.*/

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
    }
    
    func showImage() {
        guard let image = meme?.memedImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        imageView1.image = image
    }
    
    @IBAction func redo(_ sender: AnyObject) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let VC1 = storyboard.instantiateViewController(withIdentifier: "MemeEditorVC2") as! MemeEditorVC2
        VC1.meme = meme
        VC1.delegate = self
        present(VC1, animated: true, completion: nil)
    }
    
    func backToList(controller: MemeEditorVC2) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}



