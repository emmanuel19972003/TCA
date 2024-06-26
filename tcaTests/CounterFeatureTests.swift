//
//  CounterFeatureTests.swift
//  tcaTests
//
//  Created by Emmanuel Zambrano Quitian on 6/23/24.
//

import ComposableArchitecture
import XCTest


@testable import tca


@MainActor
final class CounterFeatureTests: XCTestCase {
    
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State(backGroundColor: .black)) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1 // expected stat after running
        }
        await store.send(.incrementButtonTapped) {
            $0.count = 2
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.setToZero) {
            $0.count = 0
        }
    }
    /*
     this test require that all async functions resolve, in this case
     the timer still running so the test will fail do lack of closure,
     to fix this we need to add the receive methods of the corresponding
     action.
     in this case timeTick
     */
    func testTimer() async {
        let store = TestStore(initialState: CounterFeature.State(backGroundColor: .black)) {
            CounterFeature()
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        await store.receive(\.timerTick) {
            $0.count = 2
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
            $0.count = 2
        }
    }
    
    func testTimerUsingClock() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State(backGroundColor: .black)) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testCall() async {
        let store = TestStore(initialState: CounterFeature.State(backGroundColor: .black)) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = {"\($0) is my number cool"}
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        await store.receive(\.factResponse, timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is my number cool"
        }
    }
}
