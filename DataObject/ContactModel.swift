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
    var organizationName: String
    var image: UIImage
    var identifier: String

    init(givenName: String, familyName: String, phoneNumber: [String], emailAddress: String, organizationName: String, image: UIImage, identifier: String) {
        self.givenName = givenName
        self.familyName = familyName
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.organizationName = organizationName
        self.image = image
        self.identifier = identifier
    }
}
