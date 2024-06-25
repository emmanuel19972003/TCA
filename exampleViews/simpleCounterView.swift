//
//  simpleCounterView.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import SwiftUI
import ComposableArchitecture

struct simpleCounterView: View {
    let store: StoreOf<simpleCounterFeature>
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "minus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .padding(10)
                    .background(store.buttonColor)
                    .cornerRadius(10)
                    .onTapGesture {
                        store.send(.decreesButtonTaped)
                    }
                Text ("\(store.count)")
                    .frame(width: 50, height: 25)
                    .padding(10)
                    .background(.black.opacity(0.3))
                    .cornerRadius(10)
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .padding(10)
                    .background(store.buttonColor)
                    .cornerRadius(10)
                    .onTapGesture {
                        store.send(.increaseButtonTapped)
                    }
            }
            HStack {
                Rectangle()
                    .cornerRadius(10.0)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        store.send(.changeColorTaped(.blue))
                    }
                Rectangle()
                    .cornerRadius(10.0)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.red)
                    .onTapGesture {
                        store.send(.changeColorTaped(.red))
                    }
                Rectangle()
                    .cornerRadius(10.0)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.green)
                    .onTapGesture {
                        store.send(.changeColorTaped(.green))
                    }
                Rectangle()
                    .cornerRadius(10.0)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.purple)
                    .onTapGesture {
                        store.send(.changeColorTaped(.purple))
                    }
            }
        }
    }
}

#Preview {
    simpleCounterView(store: Store(initialState: simpleCounterFeature.State()){
        simpleCounterFeature()
    })
}
