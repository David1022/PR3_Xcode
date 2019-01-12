//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
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
    }
    
    // BEGIN-UOC-3
    @IBAction func saveChanges(_ sender: Any) {
        if let userName = name.text, let userSurname = surname.text, let userStreetAddress = streetAddress.text, let userCity = city.text, let userOccupation = occupation.text, let userCompany = company.text, let _ = income.text {
            currentProfile = Profile(name: userName, surname: userSurname, streetAddress: userStreetAddress, city: userCity, occupation: userOccupation, company: userCompany, income: 1)
        }
        saveProfile()
    }
    
    func saveProfile() {
        let profileArchiveURL: URL = {
            let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory = documentsDirectories.first!
            return documentDirectory.appendingPathComponent("profile_data.archive")
        }()
       
        if let userCurrentProfile = currentProfile {
            if (NSKeyedArchiver.archiveRootObject(userCurrentProfile, toFile: profileArchiveURL.path)) {
                print("Saved profile \(userCurrentProfile.name)")
            }
        }
    }
    // END-UOC-3
    
    // BEGIN-UOC-4
    func loadProfile() -> Profile {
        return Profile(name: "", surname: "", streetAddress: "", city: "", occupation: "", company: "", income: 0)
    }
    // END-UOC-4
    
    // BEGIN-UOC-5
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
