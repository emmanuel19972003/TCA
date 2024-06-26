//
//  AddOptionView.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import SwiftUI
import ComposableArchitecture

struct AddOptionView: View {
    let store: StoreOf<AddOptionFeature>
    var body: some View {
        VStack {
            Text("basic view")
            simpleCounterView(store: store.scope(state: \.counter, action: \.counter)!)
        }
        
    }
}

#Preview {
    AddOptionView(store: Store(initialState: AddOptionFeature.State(item: shopItem())){
        AddOptionFeature()
    })
}
