//
//  FimentAppApp.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 07/04/22.
//

import SwiftUI

@main
struct FimentApp: App {
    
    let persistanceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistanceController.context)
        }
    }
}
