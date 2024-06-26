//
//  simpleCounterFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct  simpleCounterFeature {
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
        var buttonColor: Color = .blue
    }
    
    enum Action {
        case increaseButtonTapped
        case decreesButtonTaped
        case changeColorTaped(Color)
        case addToCarButtonTaped
        case delegate(Delegate)
        enum Delegate: Equatable {
            case addToCar(Int)
            case addToFavorite
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .increaseButtonTapped:
                return increaseButtonTapped()
            case .decreesButtonTaped:
                return decreesButtonTaped()
            case let .changeColorTaped(color):
                return changeColorTaped(color)
            case .delegate:
                return .none
            case .addToCarButtonTaped:
                state.count = 0
                return .none
            }
            
            func increaseButtonTapped() -> Effect<simpleCounterFeature.Action> {
                if state.count == 100 {
                    return .none
                }
                state.count += 1
                return .none
            }
            func decreesButtonTaped() -> Effect<simpleCounterFeature.Action> {
                if state.count == 0 {
                    return .none
                }
                state.count -= 1
                return .none
            }
            func changeColorTaped(_ color: Color) -> Effect<simpleCounterFeature.Action> {
                state.buttonColor = color
                return .none
            }
        }
    }
}
