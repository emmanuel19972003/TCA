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
}

@Reducer
struct AddOptionFeature {
    @ObservableState
    struct State: Equatable {
        let item: shopItem
        var counter: simpleCounterFeature.State? = simpleCounterFeature.State()
    }
    
    enum Action {
        case productTaped
        case addToCarTaped
        case counter(simpleCounterFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .productTaped:
                return .none
            case .addToCarTaped:
                return .none
            case .counter(.delegate(.addToFavorite)):
                print("action for favorite")
                return .none
            case let .counter(.delegate(.addToCar(number ))):
                print(number)
                return .none
            case .counter:
                return .none
            }
        }
        .ifLet(\.counter, action: \.counter) {
            simpleCounterFeature()
        }
    }
}
