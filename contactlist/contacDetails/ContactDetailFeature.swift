//
//  ContactDetailFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano on 26/06/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
    @ObservableState
    struct State: Equatable {
        let contact: Contact
    }
    enum Action {
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            }
        }
    }
}
