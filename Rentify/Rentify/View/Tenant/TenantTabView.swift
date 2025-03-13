//
//  TenantTabView.swift
//  Rentify
//
//  Created by CP on 13/03/25.
//

import SwiftUI

struct TenantTabView: View {
    
    @State private var selection = 0
    @ObservedObject var viewModel = PropertyViewModel()

    var body: some View {
        
        TabView(selection: $selection) {
            TenantMapView(viewModel: self.viewModel)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                .tag(0)

            
            TenantShortlistedPropertyListView(viewModel: self.viewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Shortlisted Property")
                }
                .tag(1)
            
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .appBlue
            
            appearance.stackedLayoutAppearance.normal.iconColor = .appAliceBlue.withAlphaComponent(0.5)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.appAliceBlue.withAlphaComponent(0.5)]
            
            appearance.stackedLayoutAppearance.selected.iconColor = .appColumbiaBlue
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.appColumbiaBlue]
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    TenantTabView()
}
