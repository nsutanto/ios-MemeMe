//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Nicholas Sutanto on 8/9/17.
//  Copyright © 2017 Nicholas Sutanto. All rights reserved.
//

import UIKit
import Foundation

extension EditMemeViewController: UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == TOP_STRING || textField.text == BOTTOM_STRING {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        
        // Update button
        updateButton()
        
        return true
    }
    
    
}
