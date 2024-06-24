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
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
      }
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: tcaApp.store
          )
        }
    }
}
