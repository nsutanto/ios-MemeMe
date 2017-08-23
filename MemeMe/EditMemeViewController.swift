//
//  ViewController.swift
//  MemeMe
//
//  Created by Nicholas Sutanto on 7/29/17.
//  Copyright © 2017 Nicholas Sutanto. All rights reserved.
//

import UIKit

class EditMemeViewController: UIViewController, UITextFieldDelegate {

    // String Constant
    let TOP_STRING = "TOP"
    let BOTTOM_STRING = "BOTTOM"
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -5.0]


    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navigationBarMeme: UINavigationBar!
    
    var originalImage : UIImage!
    //var topTextString : String!
    //var bottomTextString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if originalImage != nil {
            imagePickerView.image = originalImage
        }
        initTextField(topTextField, TOP_STRING)
        initTextField(bottomTextField, BOTTOM_STRING)
        updateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(.camera)
    }
    
    @IBAction func performShare(_ sender: Any) {
        let memedImageResult = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImageResult], applicationActivities: nil)
        //controller.popoverPresentationController?.sourceView = self.view
        controller.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.save(memedImageResult)
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func performCancel(_ sender: Any) {
        topTextField.text = TOP_STRING
        bottomTextField.text = BOTTOM_STRING
        imagePickerView.image = nil
        updateButton()
        dismiss(animated: true, completion: nil)
    }
    
    
    func initTextField(_ uiTextField: UITextField, _ text: String) {
        uiTextField.delegate = self
        uiTextField.text = text
        uiTextField.defaultTextAttributes = memeTextAttributes
        // Note : Default Text Attributes has to be set first before setting the allignment
        uiTextField.textAlignment = NSTextAlignment.center
    }
    
    func pickAnImage(_ imageSource: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = imageSource
        present(imagePicker, animated: true, completion: nil)
    }
    
    func updateButton() {
        shareButton.isEnabled = (imagePickerView.image == nil) ? false : true
    }
    
    func updateToolbar(_ isHidden: Bool) {
        toolBar.isHidden = isHidden
        navigationBarMeme.isHidden = isHidden
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func save(_ memedImageResult : UIImage) {
        if imagePickerView.image != nil && topTextField.text != nil && bottomTextField.text != nil
        {
            let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImageResult)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.append(meme)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func generateMemedImage() -> UIImage {
        
        updateToolbar(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        updateToolbar(false)
        
        return memedImage
    }
}

