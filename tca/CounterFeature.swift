//
//  CounterFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano on 20/06/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterFeature {
    @ObservableState
      struct State { // sate of the vars
        var count = 0
      }
      
    enum Action { // possible actions contain in the body
        case decrementButtonTapped
        case incrementButtonTapped
        case setToZero
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            case .incrementButtonTapped:
                state.count += 1
                return .none
            case .setToZero:
                state.count = 0
                return .none
            }
        }
    }
}
