//
//  AddOptionFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import Foundation
import ComposableArchitecture

struct shopItem: Equatable{
    let price = 150
    let name = "ipad"
    let image = "ipad.landscape"
    var addedToCar: Bool = false
    var isFavorite: Bool = false
}

@Reducer
struct AddOptionFeature {
    @ObservableState
    struct State: Equatable {
        var item: shopItem
        var counter: simpleCounterFeature.State? = simpleCounterFeature.State()
        var counter2: simpleCounterFeature.State? = simpleCounterFeature.State()
        var totalCounter: Int = 0
    }

    enum Action {
        case productTaped
        case addToCarTaped
        case counter(simpleCounterFeature.Action)
        case counter2(simpleCounterFeature.Action)

    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .productTaped:
                return .none
            case .addToCarTaped:
                return .none
            case .counter(.delegate(.addToFavorite)):
                state.item.isFavorite.toggle()
                return .none
            case let .counter(.delegate(.addToCar(number))):
                state.totalCounter = number + state.totalCounter
                return .none
            case .counter:
                return .none
                
            case .counter2(.delegate(.addToFavorite)):
                state.item.isFavorite.toggle()
                return .none
            case let .counter2(.delegate(.addToCar(number))):
                state.totalCounter = number + state.totalCounter
                return .none
            case .counter2:
                return .none
            }
        }
        .ifLet(\.counter, action: \.counter) {
            simpleCounterFeature()
        }
        .ifLet(\.counter2, action: \.counter2) {
            simpleCounterFeature()
        }
    }
}
