//
//  AppFeatureTests.swift
//  tcaTests
//
//  Created by Emmanuel Zambrano on 24/06/24.
//

import XCTest
import ComposableArchitecture

@testable import tca


@MainActor
final class AppFeatureTests: XCTestCase {
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()){
            AppFeature()
        }
        
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 2
        }
        await store.send(\.tab2.incrementButtonTapped) {
            $0.tab2.count = 1
        }
    }
}
