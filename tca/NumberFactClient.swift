//
//  NumberFactClient.swift
//  tca
//
//  Created by Emmanuel Zambrano Quitian on 6/23/24.
//

import Foundation
import ComposableArchitecture

/* this part is the dependencies injection and provides a model
 for normal use as well as test class (interface/protocol)
 */

struct NumberFactClient {
    static var funcsForNetwork = FuncsForNetwork()
    var fetch: (Int) async throws -> String
    var callForFive: (Bool) async throws -> String
}

//Protocol conformation, use for real use, have to use a liveValue is a must
extension NumberFactClient: DependencyKey {
    static var liveValue: NumberFactClient = NumberFactClient { number in
        let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
        return String(decoding: data, as: UTF8.self)
    } callForFive: { willFail in
        return await funcsForNetwork.callForFive(willFail: willFail)
    }
    
    static func callForFive(willFail: Bool) async -> String {
        try? await Task.sleep(for: .seconds(0.5))
        return "este es un ejemplo bien culo"
    }
}
// add the dependency
extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
//    var callForFive: NumberFactClient {
//        get { self[NumberFactClient.self] }
//        set { self[NumberFactClient.self] = newValue }
//    }
}

struct FuncsForNetwork {
    func callForFive(willFail: Bool) async -> String {
        try? await Task.sleep(for: .seconds(0.5))
        return "este es un ejemplo bien culo"
    }
}
