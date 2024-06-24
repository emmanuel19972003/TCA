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
    var fetch: (Int) async throws -> String
}
//Protocol conformation, use for real use, have to use a liveValue is a must
extension NumberFactClient: DependencyKey {
    static var liveValue: NumberFactClient = Self { number in
        let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
        return String(decoding: data, as: UTF8.self)
    }
}
// add the dependency
extension DependencyValues {
  var numberFact: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}
