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
    var body: some Scene {
        WindowGroup {
            ContentView(
            store: Store(initialState: CounterFeature.State()) {
              CounterFeature()
            }
          )
        }
    }
}
