//
//  DashboardView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView {
            SlotsView()
                .tabItem {
                    Label("Slots", systemImage: "calendar")
                }
            
            UserSettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(.blue)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
