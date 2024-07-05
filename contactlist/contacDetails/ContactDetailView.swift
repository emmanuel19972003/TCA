//
//  ContactDetailView.swift
//  tca
//
//  Created by Emmanuel Zambrano on 26/06/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
  @Bindable var store: StoreOf<ContactDetailFeature>
  
  var body: some View {
    Form {
      Button("Delete") {
        store.send(.deleteButtonTapped)
      }
    }
    .navigationTitle(Text(store.contact.name))
    .alert($store.scope(state: \.alert, action: \.alert))
  }
}

#Preview {
    ContactDetailView(store: Store(initialState: ContactDetailFeature.State(contact: Contact(id: UUID(), name: "Dane"))){
        ContactDetailFeature()
    })
}
