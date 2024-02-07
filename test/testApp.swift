//
//  testApp.swift
//  test
//
//  Created by こばとここあ on 2024/02/07.
//

import SwiftUI

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().frame(minWidth:600, idealWidth:600, maxWidth:1920,
                                minHeight: 400, idealHeight: 400, maxHeight:1080,
                                alignment:.center)
        }
    }
}
