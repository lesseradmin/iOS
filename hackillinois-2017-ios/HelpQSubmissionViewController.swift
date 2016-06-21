//
//  HelpQSubmissionViewController.swift
//  hackillinois-2017-ios
//
//  Created by Shotaro Ikeda on 6/16/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit
import CoreData

class HelpQSubmissionViewController: GenericInputView {

    /* UI Elements */
    @IBOutlet weak var techLabel: UITextField!
    @IBOutlet weak var languageLabel: UITextField!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    /* Button Actions */
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        view.endEditing(true)
        /* Check if all the labels have text */
        
        let item = Helpers.createHelpQItem(technology: techLabel.text!, language: languageLabel.text!, location: locationLabel.text!, description: descriptionLabel.text!)
        addToList(item)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var addToList: (HelpQ -> Void)!
    
    override func viewDidLoad() {
        /* Set superclass variables */
        scroll = scrollView
        textViews = [descriptionLabel]
        textFields = [techLabel, languageLabel, locationLabel]
        
        super.viewDidLoad()
    }
    
    override func textViewDidBeginEditing(textView: UITextView) {
        super.textViewDidBeginEditing(textView)
        // Scroll to make the cancel + submit buttons visible
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 450, width: 1, height: 1), animated: true)
    }
    
    override func textViewDidEndEditing(textView: UITextView) {
        super.textViewDidEndEditing(textView)
    }
}
