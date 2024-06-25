//
//  AddOptionFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddOptionFeature {
    @ObservableState
    struct State: Equatable {
        let price = 150
        let name = "ipad"
        var addedToCar: Bool = false
    }
    
    enum Action {
        case productTaped
        case addToCarTaped
    }
}
