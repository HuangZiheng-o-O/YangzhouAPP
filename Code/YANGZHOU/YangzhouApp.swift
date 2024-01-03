//
//  FoodApp.swift
//  Yangzhou
//

import SwiftUI

@main
struct YangzhouApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserData())
        }
    }
}
