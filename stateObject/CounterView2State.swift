//
//  CounterView2.swift
//  tca
//
//  Created by Emmanuel Zambrano Quitian on 6/26/24.
//

import SwiftUI

final class CounterViewModel: ObservableObject {
    @Published var count = 0

    func incrementCounter() {
        count += 1
    }
}

struct CounterView2State: View {
    @StateObject var viewModel = CounterViewModel()

    var body: some View {
        VStack {
            Text("Count is: \(viewModel.count)")
            Button("Increment Counter") {
                viewModel.incrementCounter()
            }
        }
    }
}

#Preview {
    CounterView2State()
}
