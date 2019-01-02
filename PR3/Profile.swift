//
//  Profile.swift
//  PR3
//
//  Copyright © 2018 uoc. All rights reserved.
//

import Foundation

class Profile: NSObject {
    var name: String
    var surname: String
    var streetAddress: String
    var city: String
    var occupation: String
    var company: String
    var income: Int
    
    init(name: String, surname: String, streetAddress: String, city: String, occupation: String, company: String, income: Int) {
        self.name = name
        self.surname = surname
        self.streetAddress = streetAddress
        self.city = city
        self.occupation = occupation
        self.company = company
        self.income = income
        
        super.init()
    }
}
