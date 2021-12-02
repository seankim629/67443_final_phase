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
    @State var selectedTab: Tab = .home
    @State var selectedImage: UIImage?
    @State var barcodeValue: String?
    init() {
        FirebaseApp.configure()
        UINavigationBar.appearance().barTintColor = UIColor(Color("Background Color"))
        UINavigationBar.appearance().tintColor = .white

        let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = UIColor(Color("Background Color"))
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    var body: some Scene {
        WindowGroup {
            ContentView(selectedTab: self.$selectedTab, selectedImage: self.$selectedImage, barcodeValue: self.$barcodeValue)
        }
    }
}
