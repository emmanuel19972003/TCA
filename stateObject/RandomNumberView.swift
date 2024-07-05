//
//  mainView.swift
//  tca
//
//  Created by Emmanuel Zambrano Quitian on 6/26/24.
//

import SwiftUI

struct RandomNumberView: View {
    @State var randomNumber = 0

    var body: some View {
        VStack {
            Text("Random number is: \(randomNumber)")
            Button("Randomize number") {
                randomNumber = (0..<1000).randomElement()!
            }
        }.padding(.bottom)
        
        CounterView2State()
    }
}

#Preview {
    RandomNumberView()
}
