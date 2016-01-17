//
//  ViewController.swift
//  memePickingImages
//
//  Created by Carmen Berros on 27/11/15.
//  Copyright © 2015 mcberros. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottonText: UITextField!
    @IBOutlet weak var shareAction: UIBarButtonItem!

    private let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -4
    ]

    // Text Field Delegate object
    private let memeTextDelegate = MemeTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setTextField(topText, initialText: "TOP")
        setTextField(bottonText, initialText: "BOTTOM")
    }

    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

        subscribeToKeyboardNotifications()
        shareAction.enabled = false
        UIApplication.sharedApplication().statusBarHidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        pickAnImageFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }


    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        pickAnImageFromSource(UIImagePickerControllerSourceType.Camera)
    }


    @IBAction func startActivityView(sender: AnyObject) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = saveMemeAfterSharing
        presentViewController(controller, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.shareAction.enabled = true
            });
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: {});
    }

    // Move view frame up
    func keyboardWillShow(notification: NSNotification) {
        if bottonText.isFirstResponder() && view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    // Move view frame down
    func keyboardWillHide(notification: NSNotification) {
        if bottonText.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    private func setTextField(textField: UITextField, initialText: String) {
        textField.text = initialText
        textField.delegate = memeTextDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
    }

    private func pickAnImageFromSource(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    private func saveMemeAfterSharing(activity: String?, completed: Bool, items: [AnyObject]?, err: NSError?) -> Void {
        if completed {
            save()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    private func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    private func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    private func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    private func generateMemedImage() -> UIImage {

        navigationController?.setToolbarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)

        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage: UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        return memedImage
    }

    private func save() {
        //Create the meme
        let meme = Meme(topText: topText.text!, bottonText: bottonText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
}
