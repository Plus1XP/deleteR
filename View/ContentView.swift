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
    @State private var deleteContact: String = ""
    @State private var confirmDeletion: Bool = false
    
    private var navigationTitle: Text {
        switch editMode {
        case .inactive:
            return Text("\(contactsViewModel.contacts.count) Contacts")
        case .transient:
            return Text("Deleting...")
        case .active:
            return Text("\(selection.count) / \(contactsViewModel.contacts.count) Selected")
        default:
            return Text("\(contactsViewModel.contacts.count) Contacts")
        }
    }
    
    private var deleteContactsButtonLabel: Text {
        if selection.isEmpty {
            return Text("\(Image(systemName: "trash"))")
        } else {
            if selection.count == 1 {
                return Text("\(Image(systemName: "trash")) Delete \(selection.count) contact")
            } else {
                return Text("\(Image(systemName: "trash")) Delete \(selection.count) contacts")
            }
            
        }
    }
    
    private var deleteAlertText: Text {
        if selection.count == 1 {
            return Text("Are you sure you want to delete \(selection.count) item?")
        } else {
            return Text("Are you sure you want to delete \(selection.count) items?")
        }
    }
    
    private var canDisableTrashButton: Bool {
        if (editMode != .inactive && !selection.isEmpty) {
            return false
        } else {
            return true
        }
    }
    
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
                                        .aspectRatio(contentMode: .fill)
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
                                        contactsViewModel.fetchContacts()
                                        selection.removeAll()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(navigationTitle)
            .environment(\.editMode, $editMode)
            .onAppear {
                contactsViewModel.requestAccess()
            }
            .refreshable {
                contactsViewModel.fetchContacts()
            }
            .searchable(text: $searchQuery, prompt: "Search Contacts")
            .disableAutocorrection(true)
            .alert(isPresented: $confirmDeletion) {
                Alert(title: Text("Confirm Deletion"),
                      message: deleteAlertText,
                      primaryButton: .cancel() {
                    selection.removeAll()
                    editMode = .inactive
                    confirmDeletion = false
                },
                      secondaryButton: .destructive(Text("Delete")) {
                    let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                    feedbackGenerator?.notificationOccurred(.error)
                    contactsViewModel.deleteContact(id: Array(selection))
                    contactsViewModel.fetchContacts()
                    selection.removeAll()
                    editMode = .inactive
                    confirmDeletion = false
                })
            }
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
//                            .padding(7)
//                            .background(.thinMaterial)
//                            .cornerRadius(10)
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
//                            .padding(7)
//                            .background(.thinMaterial)
//                            .cornerRadius(10)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        confirmDeletion = true
                    }) {
                        deleteContactsButtonLabel
                            .foregroundColor(canDisableTrashButton ? Color.primary : Color.red)
//                            .padding(7)
//                            .background(.thinMaterial)
//                            .cornerRadius(10)
                    }
                    .disabled(canDisableTrashButton)
                }
            }
        }
        // This fixes navigationBarTitle LayoutConstraints issue for NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
