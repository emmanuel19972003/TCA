//
//  AddContactFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactFeature {
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
        case delegate(Delegate)
        enum Delegate: Equatable {
//            case cancel
            case saveContact(Contact)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
                //                return .send(.delegate(.cancel))
                
            case .saveButtonTapped:
                //                return .send(.delegate(.saveContact(state.contact)))
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }
                
            case let .setName(name):
                state.contact.name = name
                return .none
            case .delegate: // never add logic to this case
                return .none
            }
        }
    }
}
