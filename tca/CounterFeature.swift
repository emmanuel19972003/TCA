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
    struct State: Equatable { // sate of the vars
        var count = 0
        var isLoading = false
        var fact: String?
        var isTimerRunning = false
    }
    
    enum Action { // possible actions contain in the body
        case decrementButtonTapped
        case incrementButtonTapped
        case setToZero
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID {
        case timer
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                return decrementByOne()
                
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
                
            case .setToZero:
                state.count = 0
                state.fact = nil
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                //                return .run { [count = state.count] send in
                //                    let (data, _) = try await URLSession.shared
                //                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                //                    let fact = String(decoding: data, as: UTF8.self)
                //                    await send(.factResponse(fact))
                //                }
                return .run { [count = state.count] send in
                    try await send(.factResponse(self.numberFact.fetch(count)))
                }
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)// set the id for the cancellable action
                } else {
                    return .cancel(id: CancelID.timer)
                }
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
            }
            
            func decrementByOne() -> Effect<CounterFeature.Action> {
                state.count -= 1
                state.fact = nil
                return .none
            }
        }
    }
}
