//
//  ContentView.swift
//  tca
//
//  Created by Emmanuel Zambrano on 20/06/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<CounterFeature>
    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.title)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("set to 0") {
                    store.send(.setToZero)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                
            }
            
            Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                    store.send(.toggleTimerButtonTapped)
                  }
                  .font(.largeTitle)
                  .padding()
                  .background(Color.black.opacity(0.1))
                  .cornerRadius(10)

            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            Spacer()
            
        }.padding(.top)
    }
}

#Preview {
    ContentView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
