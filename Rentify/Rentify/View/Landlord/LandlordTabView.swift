//
//  LandlordTabView.swift
//  Rentify
//
//  Created by CP on 11/03/25.
//

import SwiftUI

struct LandlordTabView: View {
    @State private var selection = 0

    var body: some View {
        
        TabView(selection: $selection) {
            LandlordAddPropertyView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Add Property")
                }
                .tag(0)
            
            LandlordMapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                .tag(1)
            
            LandlordProfileView()
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
            appearance.backgroundColor = .appColumbiaBlue
            
            appearance.stackedLayoutAppearance.normal.iconColor = .appGrayBlue
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.appGrayBlue]
            
            appearance.stackedLayoutAppearance.selected.iconColor = .appBlue
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.appBlue]
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    LandlordTabView()
}
