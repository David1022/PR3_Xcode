//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UITextFieldDelegate {
    var currentProfile: Profile?
    
    // BEGIN-UOC-2
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var occupation: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var income: UITextField!
    // END-UOC-2
    
    override func viewDidLoad() {
        currentProfile = loadProfile()
        
        initializeOutlets()
    }
    
    // BEGIN-UOC-3
    @IBAction func saveChanges(_ sender: Any) {
        if let userName = name.text, let userSurname = surname.text, let userStreetAddress = streetAddress.text, let userCity = city.text, let userOccupation = occupation.text, let userCompany = company.text, let _ = income.text {
            currentProfile = Profile(name: userName, surname: userSurname, streetAddress: userStreetAddress, city: userCity, occupation: userOccupation, company: userCompany, income: 1)
        }
        saveProfile()
    }
    
    // Declared let as a global field in order to use it in saveProfile and loadProfile
    let profileArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("profile_data.archive")
    }()
    
    func saveProfile() {
        if let userCurrentProfile = currentProfile {
            if (NSKeyedArchiver.archiveRootObject(userCurrentProfile, toFile: profileArchiveURL.path)) {
                print("Saved profile \(userCurrentProfile.name)")
            }
        }
    }
    // END-UOC-3
    
    // BEGIN-UOC-4
    var profiles: Profile?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let savedProfiles =
            NSKeyedUnarchiver.unarchiveObject(withFile: profileArchiveURL.path) as? Profile {
            profiles = savedProfiles
        }
    }
    
    func loadProfile() -> Profile {
        if let savedProfiles = profiles {
            let profile = savedProfiles
            name.text = profile.name
            surname.text = profile.surname
            streetAddress.text = profile.streetAddress
            city.text = profile.city
            occupation.text = profile.occupation
            company.text = profile.company
            income.text = "\(profile.income)"
            
            return profile
        }
        
        return Profile(name: "", surname: "", streetAddress: "", city: "", occupation: "", company: "", income: 0)
    }
    // END-UOC-4
    
    // BEGIN-UOC-5
    func initializeOutlets() {
        self.name.delegate = self
        self.surname.delegate = self
        self.streetAddress.delegate = self
        self.city.delegate = self
        self.occupation.delegate = self
        self.company.delegate = self
        self.income.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == name) {
            surname.becomeFirstResponder()
        } else if (textField == surname) {
            streetAddress.becomeFirstResponder()
        } else if (textField == streetAddress) {
            city.becomeFirstResponder()
        } else if (textField == city) {
            occupation.becomeFirstResponder()
        } else if (textField == occupation) {
            company.becomeFirstResponder()
        } else if (textField == company) {
            income.becomeFirstResponder()
        } else if (textField == income) {
            self.view.endEditing(true)
        }
        return false
    }
    // END-UOC-5
    
    // BEGIN-UOC-6
    // END-UOC-6
    
    // BEGIN-UOC-7
    func loadProfileImage() -> UIImage? {
        return UIImage(named: "EmptyProfile.png")
    }
    
    func saveProfileImage(_ image: UIImage) {
        
    }
    // END-UOC-7
}
