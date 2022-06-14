//
//  ContentView.swift
//  Shared
//
//  Created by Plus1XP on 13/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contactsViewModel = ContactsViewModel()
    @State private var editMode: EditMode = .inactive
    @State private var selection: Set<String> = []
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(contactsViewModel.sectionDictionary.keys.sorted(), id:\.self) { key in
                    if let contacts = contactsViewModel.sectionDictionary[key]!.filter({ (contact) -> Bool in
                        self.searchQuery.isEmpty ? true :
                        "\(contact)".lowercased().contains(self.searchQuery.lowercased())}), !contacts.isEmpty {
                        Section(header: Text("\(key)").font(.callout).fontWeight(.medium)) {
                            ForEach(contacts, id: \.identifier) { contact in
                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(contact.givenName)
                                                .fontWeight(.medium)
                                            Text(contact.familyName)
                                                .fontWeight(.light)
                                        }
                                        Text(contact.phoneNumber.joined(separator: ", "))
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                    }
                                    Spacer()
                                    Image(uiImage: contact.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
//                                        .overlay(
//                                            Circle()
//                                                .stroke(lineWidth: 1)
//                                                .foregroundColor(.secondary)
//                                        )
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button("Delete", role: .destructive) {
                                        let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                                        feedbackGenerator?.notificationOccurred(.error)
                                        contactsViewModel.deleteContact(id: [contact.identifier])
                                        fetchContacts()
                                        selection.removeAll()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(editMode == .inactive ? "\(contactsViewModel.contacts.count) Contacts" : "\(selection.count) / \(contactsViewModel.contacts.count) Selected")
            .environment(\.editMode, $editMode)
            .onAppear {
                fetchContacts()
            }
            .refreshable {
                fetchContacts()
            }
            .searchable(text: $searchQuery, prompt: "Search Contacts")
            .disableAutocorrection(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if selection.isEmpty {
                            for contact in contactsViewModel.contacts {
                                selection.insert(contact.identifier)
                            }
                        } else {
                            selection.removeAll()
                        }
                    }) {
                        Text(selection.isEmpty ? "Select All" : "Deselect All")
                            .foregroundColor(editMode == .inactive ? Color.primary : Color.blue)
                            .padding(7)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                    .disabled(editMode == .inactive ? true : false)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if editMode == .inactive {
                            let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                            feedbackGenerator?.notificationOccurred(.success)
                            editMode = .active
                        }
                        else if editMode == .active {
                            let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                            feedbackGenerator?.notificationOccurred(.warning)
                            selection.removeAll()
                            editMode = .inactive
                        }
                    } label: {
                        Text(editMode == .inactive ? "Edit" : "Done")
                            .padding(7)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                        feedbackGenerator?.notificationOccurred(.error)
                        contactsViewModel.deleteContact(id: Array(selection))
                        fetchContacts()
                        selection.removeAll()
                        editMode = .inactive
                    }) {
                        Text(selection.isEmpty ? "\(Image(systemName: "trash"))" : "\(Image(systemName: "trash")) Delete \(selection.count) contacts")
                            .foregroundColor(canDisableTrashLabel() ? Color.primary : Color.red)
                            .padding(7)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                    .disabled(canDisableTrashLabel())
                }
            }
        }
        // This fixes navigationBarTitle LayoutConstraints issue for NavigationView
        .navigationViewStyle(.stack)
    }
    
    func fetchContacts() {
        DispatchQueue.main.async {
            contactsViewModel.fetchContacts()
        }
    }
    
    func canDisableTrashLabel() -> Bool {
        var value: Bool = true
        if editMode != .inactive {
            if !selection.isEmpty {
                value = false
            }
        }
        return value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
