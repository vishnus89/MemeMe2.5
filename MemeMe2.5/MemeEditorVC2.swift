//
//  ViewController.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/11/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
//

import UIKit


protocol RedoDelegate {
    func backToList(controller: MemeEditorVC2)
}


class MemeEditorVC2: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var ShareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    var image: UIImage?
    var meme: Meme?
    var delegate: RedoDelegate?
    let imagePicker = UIImagePickerController()
    //Attributes for Styling Texts
    let memeTextAttribues = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 40)!,
        NSStrokeWidthAttributeName : NSNumber(value: -3.0 as Float)]
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        // For camera source availble
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        ShareButton.isEnabled = imagePickerView.image != nil
        showMemeIfAvailable()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeFont(topTextField)
        memeFont(bottomTextField)
        view.frame.origin.y = 0
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MemeEditorVC2.handleTap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    //Meme text attributes
    func memeFont(_ font: UITextField){
        font.defaultTextAttributes = memeTextAttribues
        font.textAlignment = NSTextAlignment.center
        font.delegate = self
    }
    func showMemeIfAvailable(){
        if meme != nil {
            topTextField.text = meme?.topText
            bottomTextField.text = meme?.bottomText
            imagePickerView.image = meme?.image
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .scaleAspectFit
        }
        imagePickerView.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func save(memeImage: UIImage) {
        // Creating the meme
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage)
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate; appDelegate.memes.append(meme)
    }
    func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true
        navigationBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        navigationBar.isHidden = false
        return memedImage
    }
    // MARK:  Methods for keyboard
    func configure(textField : UITextField){
        textField.defaultTextAttributes = memeTextAttribues
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self
    }
    func keyboardWillShow(_ notification:Notification) {
        if view.frame.origin.y == 0 {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        // CGRect
        if bottomTextField.isFirstResponder {
            return keyboardSize.cgRectValue.height
        } else {
            return 0
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == topTextField && textField.text! == "TOP") || (textField == bottomTextField && textField.text! == "BOTTOM") {
            textField.text = ""
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == topTextField && textField.text! == "" {
            textField.text = "TOP"
        }
        if textField == bottomTextField && textField.text! == "" {
            textField.text = "BOTTOM"
        }
    }
    //Mark: Methods for Keyboard Notificaitons
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func handleTap(_ sender: UIGestureRecognizer) {
        previewMeme()
    }
    
    func previewMeme(){
        topTextField?.endEditing(false)
        bottomTextField?.endEditing(false)
        
        if imagePickerView.image != nil {
            navigationBar.isHidden = !navigationBar.isHidden
            toolBar.isHidden = !toolBar.isHidden
            topTextField.isEnabled = !topTextField.isEnabled
            bottomTextField.isEnabled = !bottomTextField.isEnabled
        }
    }
    
    func pick(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pick(sourceType: .photoLibrary)
        
    }
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        pick(sourceType: .camera)
        
    }
    // To cancel Meme Editing
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.2){ [unowned self] in
            self.topTextField.text = "TOP"
            self.bottomTextField.text = "BOTTOM"
            self.imagePickerView.image = nil
        }
        print("cancel is pressed")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { activity, completed, returned, error in
            if completed {
                //Save the image
                self.save(memeImage: memedImage)
                //Dismiss the view controller
                self.dismiss(animated: true, completion: nil)
                
//                if self.delegate != nil {
//                    self.delegate?.backToList(controller: self)
//                }
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
}




