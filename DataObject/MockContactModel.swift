//
//  MockContactModel.swift
//  deleteR (iOS)
//
//  Created by Plus1XP on 15/06/2022.
//

import SwiftUI

struct MockContactModel {
    func mockContacts() -> [ContactsModel] {
        var contacts: [ContactsModel] = []
        contacts.append(ContactsModel(givenName: "Anita", familyName: "Bath", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"woman1")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Anya", familyName: "Neeze", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))", "+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"woman2")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Kenny", familyName: "Dewitt", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"man1")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Yuri", familyName: "Nator", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"man2")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Stella", familyName: "Wang", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))", "+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"woman3")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Dixon", familyName: "Kuntz", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))", "+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"man3")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Wayne", familyName: "Kerr", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"man4")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Buster", familyName: "Himen", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))", "+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"man5")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Lou", familyName: "Briccant", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"woman4")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Fonda", familyName: "Cox", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"woman5")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Stacy", familyName: "Rect", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))", "+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"woman6")!, identifier: UUID().uuidString))
        contacts.append(ContactsModel(givenName: "Dang", familyName: "Lin-Wang", phoneNumber: ["+\(Int.random(in: 1...99)) \(Int.random(in: 2135...9812)) \(Int.random(in: 123456...923456))"], emailAddress: "blank@blank.com" as String, organizationName: "Mega Corp", image: UIImage(named:"man6")!, identifier: UUID().uuidString))
        return contacts
    }
}
