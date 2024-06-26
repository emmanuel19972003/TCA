//
//  ContactDetailView.swift
//  tca
//
//  Created by Emmanuel Zambrano on 26/06/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>
    var body: some View {
        Form {
           }
           .navigationTitle(
            Text(store.contact.name)
           )
    }
}

#Preview {
    ContactDetailView(store: Store(initialState: ContactDetailFeature.State(contact: Contact(id: UUID(), name: "Dane"))){
        ContactDetailFeature()
    })
}
