//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
        
        self.initializeOutlets()
        self.tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    // BEGIN-UOC-3
    @IBAction func saveChanges(_ sender: Any) {
        guard let income = self.income.text
            else {
                return
        }
        let userIncome: Int? = Int(income)

        guard let userName = name.text,
            let userSurname = surname.text,
            let userStreetAddress = streetAddress.text,
            let userCity = city.text,
            let userOccupation = occupation.text,
            let userCompany = company.text,
            let userInc = userIncome
        else {
            let alert = UIAlertController(title: "Profile NOT saved",
                                          message: "The INCOME field must be a number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: {self.income.text = ""})
            return
        }
            self.currentProfile = Profile(name: userName,
                                     surname: userSurname,
                                     streetAddress: userStreetAddress,
                                     city: userCity,
                                     occupation: userOccupation,
                                     company: userCompany,
                                     income: userInc)
        saveProfile()
        if let image = self.profileImage.image {
            self.saveProfileImage(image)
        }
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
                let alert = UIAlertController(title: "Profile Saved",
                                              message: "Your profile is succesfully saved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    // END-UOC-3
    
    // BEGIN-UOC-4
    var profile: Profile?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let savedProfile =
            NSKeyedUnarchiver.unarchiveObject(withFile: profileArchiveURL.path) as? Profile {
            self.profile = savedProfile
        }
    }
    
    func loadProfile() -> Profile {
        guard let savedProf = self.profile
        else {
            return Profile(name: "", surname: "", streetAddress: "", city: "", occupation: "", company: "", income: 0)
        }
        self.profileImage.image = loadProfileImage()
        
        self.name.text = savedProf.name
        self.surname.text = savedProf.surname
        self.streetAddress.text = savedProf.streetAddress
        self.city.text = savedProf.city
        self.occupation.text = savedProf.occupation
        self.company.text = savedProf.company
        self.income.text = "\(savedProf.income)"
        
        return savedProf
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
        if (textField == self.name) {
            self.surname.becomeFirstResponder()
        } else if (textField == self.surname) {
            self.streetAddress.becomeFirstResponder()
        } else if (textField == self.streetAddress) {
            self.city.becomeFirstResponder()
        } else if (textField == self.city) {
            self.occupation.becomeFirstResponder()
        } else if (textField == self.occupation) {
            self.company.becomeFirstResponder()
        } else if (textField == self.company) {
            self.income.becomeFirstResponder()
        } else if (textField == self.income) {
            self.hideKeyboard()
        }
        return false
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    // END-UOC-5
    
    // BEGIN-UOC-6
    @IBOutlet var profileImage: UIImageView!
    
    @IBAction func takePicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            //I have no physical device to test this behavior
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            return
        }
        self.profileImage.image = image
//        saveProfileImage(image)
        dismiss(animated: true, completion: nil)
    }
    // END-UOC-6
    
    // BEGIN-UOC-7
    func loadProfileImage() -> UIImage? {
        guard let image = UIImage(contentsOfFile: fileURLInDocumentDirectory("profile_image.png").path)
            else{
                return UIImage(named: "EmptyProfile.png")
            }
        return image
    }
    
    public var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }
    
    public func fileURLInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }

    func saveProfileImage(_ image: UIImage) {
        guard let data = image.pngData() else {
            return
        }
        let fileURL = self.fileURLInDocumentDirectory("profile_image.png")
        do {
            try data.write(to: fileURL)
        } catch {
        }
    }
    // END-UOC-7
}
