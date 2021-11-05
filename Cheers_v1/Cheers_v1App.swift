//
//  Cheers_v1App.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 10/28/21.
//

import SwiftUI
import FirebaseCore

@main
struct Cheers_v1App: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
