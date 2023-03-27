//
//  ContentView.swift
//  Swipable-CardView
//
//  Created by 이건우 on 2023/03/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CardView()
                .padding()
                .offset(y: 190)
        }
        .background(Color.accentColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
