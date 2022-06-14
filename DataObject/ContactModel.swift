//
//  ContactModel.swift
//  deleteR (iOS)
//
//  Created by Plus1XP on 14/06/2022.
//

import SwiftUI

struct ContactsModel {
    let givenName: String
    let familyName: String
    let phoneNumber: [String]
    let emailAddress: String
    var identifier: String
    var image: UIImage

    init(givenName:String, familyName:String, phoneNumber:[String], emailAddress:String, identifier:String, image: UIImage) {
        self.givenName = givenName
        self.familyName = familyName
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.identifier = identifier
        self.image = image
    }
}
