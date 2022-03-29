//
//  Realm_Intro_3App.swift
//  Realm Intro-3
//
//  Created by Stewart Lynch on 2022-03-07.
//

import SwiftUI

@main
struct Realm_Intro_3App: App {
    @StateObject var realmManager = RealmManager(name: "example3")
    var body: some Scene {
        WindowGroup {
            TabView {
                CountriesListView()
                    .tabItem {
                        Label("Countries", systemImage: "list.dash")
                    }
                    .environmentObject(realmManager)
                AllCitiesListView()
                    .tabItem {
                        Label("Cities", systemImage: "list.dash")
                    }
                
            }
                .onAppear {
                     UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
