//
//  AppFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano Quitian on 6/23/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppFeature {// Reducer Composition
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
    }
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
    }
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }
        Reduce { state, action in
            // Core logic of the app feature
            return .none
        }
    }
}

struct AppView: View {
    // let store1: StoreOf<CounterFeature>
    // let store2: StoreOf<CounterFeature>
    let store: StoreOf<AppFeature>//single source of truth
    
    var body: some View {
        TabView {
            CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Image(systemName: "timer")
                    Text("Counter 1")
                }
            
            CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Image(systemName: "gauge.with.needle")
                    Text("Counter 2")
                }
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State()){
        AppFeature()
    })
}
