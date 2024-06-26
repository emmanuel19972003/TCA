//
//  ContactsFeature.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import Foundation
import ComposableArchitecture


struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable {
        // @Presents var addContact: AddContactFeature.State?
        // @Presents var alert: AlertState<Action.Alert>?
        @Presents var destination: Destination.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        //        case addContact(PresentationAction<AddContactFeature.Action>)// this allow the parent to know any action perform on the child
        //        case alert(PresentationAction<Alert>)
        
        case destination(PresentationAction<Destination.Action>)// replace multiple actions with destinations
        case deleteButtonTapped(id: Contact.ID)
        enum Alert: Equatable {//Delegate
            case confirmDeletion(id: Contact.ID)
        }
    }
    
    @Reducer(state: .equatable)// to make it Equatable
    enum Destination {
        case addContact(AddContactFeature)
        case alert(AlertState<ContactsFeature.Action.Alert>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                //                state.addContact = AddContactFeature.State(
                //                    contact: Contact(id: UUID(), name: "")
                //                    )
                state.destination = .addContact(
                    AddContactFeature.State(
                        contact: Contact(id: UUID(), name: "")
                    )
                )
                return .none
                
                //            case .addContact(.presented(.delegate(.cancel))):
                //                    state.addContact = nil
                //                    return .none
            case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
                //                guard let contact = state.addContact?.contact else {
                //                    return .none
                //                }
                state.contacts.append(contact)
                //                state.addContact = nil //not necessary due self dismiss of child view
                return .none
                //            case let .alert(.presented(.confirmDeletion(id: id))):
            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.contacts.remove(id: id)
                return .none
                
            case .destination:
                    return .none
            case .deleteButtonTapped(id: let id):
                state.destination = .alert(
                          AlertState {
                            TextState("Are you sure?")
                          } actions: {
                            ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                              TextState("Delete")
                            }
                          }
                        )
                return .none
            }
            
        }
        .ifLet(\.$destination, action: \.destination) // join alert actions
    }
    
}


