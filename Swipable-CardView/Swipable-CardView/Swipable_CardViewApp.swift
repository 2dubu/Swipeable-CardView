//
//  Swipable_CardViewApp.swift
//  Swipable-CardView
//
//  Created by 이건우 on 2023/03/28.
//

import SwiftUI

@main
struct Swipable_CardViewApp: App {
    var catImages: [String] = ["cat8", "cat7", "cat6", "cat5", "cat4", "cat3", "cat2", "cat1"]
    
    var body: some Scene {
        WindowGroup {
            ContentView(catImageNames: catImages)
        }
    }
}
