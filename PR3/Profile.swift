//
//  Profile.swift
//  PR3
//
//  Copyright © 2018 uoc. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding {
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

    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(surname, forKey: "surname")
        aCoder.encode(streetAddress, forKey: "streetAddress")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(occupation, forKey: "occupation")
        aCoder.encode(company, forKey: "company")
        aCoder.encode(income, forKey: "income")
    }

    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let surname = aDecoder.decodeObject(forKey: "surname") as! String
        let streetAddress = aDecoder.decodeObject(forKey: "streetAddress") as! String
        let city = aDecoder.decodeObject(forKey: "city") as! String
        let occupation = aDecoder.decodeObject(forKey: "occupation") as! String
        let company = aDecoder.decodeObject(forKey: "company") as! String
        let income = aDecoder.decodeInteger(forKey: "income")

        self.init(name: name, surname: surname, streetAddress: streetAddress, city: city, occupation: occupation, company: company, income: 1)
    }
}
