//
//  TelemedicineAppApp.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

@main
struct TelemedicineAppApp: App {
    
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
