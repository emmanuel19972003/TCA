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
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                ForEach(store.contacts) { contact in
                    NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button {
                                store.send(.deleteButtonTapped(id: contact.id))
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .buttonStyle(.borderless)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } destination: { store in
            ContactDetailView(store: store)
        }
        .sheet(
            item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
        ) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
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
