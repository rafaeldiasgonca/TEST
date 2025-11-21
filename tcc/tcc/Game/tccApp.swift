//
//  tccApp.swift
//  tcc
//
//  Created by Rafael Dias Gonçalves on 13/11/25.
//

import SwiftUI

@main
struct tccApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .black
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .toolbarBackground(.white, for: .navigationBar)
                .toolbarColorScheme(.light, for: .navigationBar)
                .background(Color.white)
        }

    }
}
