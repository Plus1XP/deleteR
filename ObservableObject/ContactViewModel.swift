//
//  ContactViewModel.swift
//  deleteR (iOS)
//
//  Created by Plus1XP on 14/06/2022.
//

import Contacts
import SwiftUI

class ContactsViewModel: ObservableObject {
    @Published var contacts = [ContactsModel]()
    @Published var sectionDictionary : Dictionary<String , [ContactsModel]> = [:]
    let contactStore = CNContactStore()
    
    func requestAccess() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            self.fetchContacts()
        case .denied:
            contactStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.fetchContacts()
                }
            }
        case .restricted, .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.fetchContacts()
                }
            }
        @unknown default:
            print("error")
        }
    }

    func fetchContacts() -> Void {
        contacts.removeAll()
        let key = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey, CNContactThumbnailImageDataKey, CNContactOrganizationNameKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        request.sortOrder = CNContactSortOrder.userDefault
        DispatchQueue.main.async {
            try? self.contactStore.enumerateContacts(with: request, usingBlock: { (contact, stoppingPointer) in
                let givenName = contact.givenName != "" ? contact.givenName : contact.organizationName
                let familyName = contact.familyName
                let emailAddress = contact.emailAddresses.first?.value ?? ""
                let phoneNumber: [String] = contact.phoneNumbers.map{ $0.value.stringValue }
                let organizationName = contact.organizationName
                var image = UIImage()
                if contact.thumbnailImageData != nil {
                    image = UIImage(data: contact.thumbnailImageData!)!
                }
                let identifier = contact.identifier
                self.contacts.append(ContactsModel(givenName: givenName, familyName: familyName, phoneNumber: phoneNumber, emailAddress: emailAddress as String, organizationName: organizationName, image: image, identifier: identifier))
                debugPrint("\(givenName) \(familyName) \(identifier)")
            })
            self.sectionDictionary = self.getSectionedDictionary()
        }
    }
    
    func deleteContact(id: [String]) -> Void {
        let pred = CNContact.predicateForContacts(withIdentifiers: id)
        let key = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey] as [CNKeyDescriptor]
        do {
            let contacts = try contactStore.unifiedContacts(matching: pred, keysToFetch: key)
            guard contacts.count > 0 else {
                print("No contacts found")
                return
            }
            DispatchQueue.main.async {
                for contact in contacts {
                    let mutableContact = contact.mutableCopy() as! CNMutableContact
                    let req = CNSaveRequest()
                    req.delete(mutableContact)
                    do {
                        try self.contactStore.execute(req)
                        print("Success, You deleted: \(contact.givenName) \(contact.familyName) \(contact.identifier)")
                    } catch let err {
                        print("Error = \(err)")
                    }
                }
            }
        } catch let fetchError {
            print(fetchError)
        }
    }
    
    func getSectionedDictionary() -> Dictionary <String , [ContactsModel]> {
        let sectionDictionary: Dictionary<String, [ContactsModel]> = {
            return Dictionary(grouping: contacts, by: {
                let name = $0.givenName
                let organization = $0.organizationName
                
                var firstChar: String {
                    if name != "" {
                        let normalizedName = name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                        return String(normalizedName.first!).uppercased()
                    }
                    if organization != "" {
                        let normalizedOrganization = organization.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                        return String(normalizedOrganization.first!).uppercased()
                    }
                    else {
                        return ""
                    }
                }
                return firstChar
            })
        }()
        return sectionDictionary
    }
}
