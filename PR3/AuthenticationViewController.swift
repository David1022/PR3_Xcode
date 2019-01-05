//
//  AuthenticationViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourthField: UITextField!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    @IBOutlet weak var backButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterTextConstraint: NSLayoutConstraint!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // We first check that the user is only entering numeric characters
        let numericSet = CharacterSet.decimalDigits
        let stringSet = CharacterSet(charactersIn: string)
        let onlyNumeric = numericSet.isSuperset(of: stringSet)
        
        if !onlyNumeric {
            return false
        }
        
        // We then check that the length of resulting text will be smaller or equal to 1
        let currentString = textField.text as NSString?
        let resultingString = currentString?.replacingCharacters(in: range, with: string)
        
        if let resultingLength = resultingString?.count, resultingLength <= 1 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        doAuthentication()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func doAuthentication() {
        var validCode: Bool
        if let firstCode = firstField.text, let secondCode = secondField.text, let thirdCode = thirdField.text, let fourthCode = fourthField.text {
            let fullCode = firstCode + secondCode + thirdCode + fourthCode
            validCode = Services.validate(code: fullCode)
        } else {
            validCode = false
        }
        
        if validCode {
            // BEGIN-UOC-1
            fadeOutViews()
//            self.performSegue (withIdentifier: "SegueToMainNavigation", sender: self)
            // END-UOC-1
        } else {
            let errorMessage = "Sorry, the entered code is not valid"
            let errorTitle = "We could not autenticate you"
            Utils.show (Message: errorMessage, WithTitle: errorTitle, InViewController: self)
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        switch sender {
        case firstField:
            secondField.becomeFirstResponder()
        case secondField:
            thirdField.becomeFirstResponder()
        case thirdField:
            fourthField.becomeFirstResponder()
        default:
            doAuthentication()
        }
    }
    
    func fadeOutViews() {
        UIView.animate(withDuration: 0.5, animations: {self.firstLabel.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {self.secondLabel.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {self.thirdLabel.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {self.fourthLabel.alpha = 0})
        
        UIView.animate(withDuration: 0.5, animations: {self.firstField.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {self.secondField.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {self.thirdField.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {self.fourthField.alpha = 0},
                       completion: {_ in self.layoutViews()})
    }
    
    func layoutViews() {
        UIView.animate(withDuration: 1, animations: {
            self.backButtonConstraint.constant = self.view.bounds.width
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, animations: {
            self.nextButtonConstraint.constant = -self.view.bounds.width
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, animations: {
            self.enterTextConstraint.constant = -self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: {_ in self.performSegue (withIdentifier: "SegueToMainNavigation", sender: self)})
    }
}
