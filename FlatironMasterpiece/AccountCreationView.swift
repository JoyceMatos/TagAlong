//
//  AccountCreationView.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let FIRSTNAME = "firstNameTextField"
    static let LASTNAME = "lastNameTextField"
    static let EMAILCONFIRMATION = "emailTextField"
    static let PASSWORD = "password"
    static let PASSWORDVERIFICATION = "passwordverification"
    static let INDUSTRY = "industry"
    static let JOBTITLE = "jobtitle"
    
}

class AccountCreationView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameEntryTextField: UITextField!
    @IBOutlet weak var lastNameEntryTextField: UITextField!
    @IBOutlet weak var emailEntryTextField: UITextField!
    @IBOutlet weak var passwordEntryTextField: UITextField!
    @IBOutlet weak var passwordVerificationTextField: UITextField!
    @IBOutlet weak var industryEntryTextField: UITextField!
    @IBOutlet weak var jobEntryTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var firstNameConfirmed = false
    var lastNameConfirmed = false
    var emailConfirmed = false
    var password = false
    var industry = false
    var jobtitle = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    firstNameEntryTextField.accessibilityLabel = Constants.FIRSTNAME
        lastNameEntryTextField.accessibilityLabel = Constants.LASTNAME
        emailEntryTextField.accessibilityLabel = Constants.EMAILCONFIRMATION
        passwordEntryTextField.accessibilityLabel = Constants.PASSWORD
        passwordVerificationTextField.accessibilityLabel = Constants.PASSWORDVERIFICATION
        industryEntryTextField.accessibilityLabel = Constants.INDUSTRY
        jobEntryTextField.accessibilityLabel = Constants.JOBTITLE
        
    }

    func animateFields(textField: UITextField, isInputValid: Bool) {
        let greenColor = UIColor.green.withAlphaComponent(0.1)
        let redColor = UIColor.red.withAlphaComponent(0.1)
        let unchangedState = textField.transform
        let pulseScale: CGFloat = 1.03
        let shake = textField.frame.width * 0.02
        
        if isInputValid {
            UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    textField.backgroundColor = greenColor
                }
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    textField.transform = CGAffineTransform(scaleX: pulseScale, y: pulseScale)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1/3) {
                    textField.transform = unchangedState
                }
                
            }, completion: nil)

        
        
        
        }
    }
    
    
    
    
    
//    firstNameEntry
//    lastNameEntry
//    emailEntry
//    passwordEntry
//    passwordVerification
//    industryEntry
//    jobEntry
//    
    
    
}
