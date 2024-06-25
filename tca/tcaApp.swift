//
//  tcaApp.swift
//  tca
//
//  Created by Emmanuel Zambrano on 20/06/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct tcaApp: App {
//    static let store = Store(initialState: AppFeature.State()) {
//        AppFeature()
//      }
//    var body: some Scene {
//        WindowGroup {
//            AppView(
//                store: tcaApp.store
//          )
//        }
//    }
    static let store = Store(initialState: ContactsFeature.State(contacts: [
        Contact(id: UUID(), name: "Dane"),
        Contact(id: UUID(), name: "Emma"),
        Contact(id: UUID(), name: "Juanis")
        
    ])){
        ContactsFeature()
    }
    var body: some Scene {
        WindowGroup {
            ContactsView(
                store: tcaApp.store
          )
        }
    }

}
