//
//  ContactsView.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    @Bindable var store: StoreOf<ContactsFeature>
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        store.send(.addButtonTapped)
                    }, label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    })
                }
            }
        }
        .sheet(
            item: $store.scope(state: \.addContact, action: \.addContact)
        ) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
    }
}

#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(contacts: [
        Contact(id: UUID(), name: "Dane"),
        Contact(id: UUID(), name: "Emma"),
        Contact(id: UUID(), name: "Juanis")
        
    ])){
        ContactsFeature()
    })
}
