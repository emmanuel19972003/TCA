//
//  EmmaTest.swift
//  tca
//
//  Created by Emmanuel Zambrano on 25/06/24.
//

import SwiftUI

struct EmmaTest: View {
    @State var name: String = ""
    var body: some View {
        VStack {
            TextField("Hint", text: $name)
            Button("Print value") {
                print($name)
            }
        }.padding()
        
        
    }
}

#Preview {
    EmmaTest()
}
