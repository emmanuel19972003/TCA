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
            ZStack {
                Rectangle()
                    .frame(height: 50)
                    .cornerRadius(20)
                    .foregroundColor(.black.opacity(0.2))
                HStack {
                    Text("Car")
                    Spacer()
                    Text("\(store.totalCounter)")
                    Image(systemName: "basket")
                    
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(store.item.isFavorite ? .red : .gray)
            simpleCounterView(store: store.scope(state: \.counter, action: \.counter)!)
            Spacer()
        }
        
    }
}

#Preview {
    AddOptionView(store: Store(initialState: AddOptionFeature.State(item: shopItem())){
        AddOptionFeature()
    })
}
