//
//  tcaApp.swift
//  tca
//
//  Created by Emmanuel Zambrano on 20/06/24.
//

import SwiftUI
import ComposableArchitecture

enum selectedView {
    case timer
    case contactList
    case examples
    case RandomNumberView
}

@main
struct tcaApp: App {
    let mainView: selectedView = .RandomNumberView
    
    //    static let store = Store(initialState: ContactsFeature.State(contacts: [
    //        Contact(id: UUID(), name: "Dane"),
    //        Contact(id: UUID(), name: "Emma"),
    //        Contact(id: UUID(), name: "Juanis")
    //
    //    ])){
    //        ContactsFeature()
    //    }
    var body: some Scene {
        WindowGroup {
            switch mainView {
            case .contactList:
                
                let store = Store(initialState: ContactsFeature.State(contacts: [
                    Contact(id: UUID(), name: "Dane"),
                    Contact(id: UUID(), name: "Emma"),
                    Contact(id: UUID(), name: "Juanis")
                    
                ])){
                    ContactsFeature()
                }
                ContactsView(
                    store: store
                )
                
            case .timer:
                let store = Store(initialState: AppFeature.State()) {
                    AppFeature()
                }
                
                AppView(
                    store: store
                )
            case .examples:
                let store = Store(initialState: AddOptionFeature.State(item: shopItem())) {
                    AddOptionFeature()
                }
                
                AddOptionView(
                    store: store
                )
            case .RandomNumberView:
                RandomNumberView()
            }
        }
    }
}
